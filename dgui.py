#!/usr/bin/env python3
import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import json
import copy
import platform

# ===================== 原始数据结构 =====================
base_dict = {
    'Fields': {
        0: {
            'Access': 'RW',
            'BitWidth': '32',
            'DefaultValue': '0',
            'EnableBy': '',
            'FieldName': 'FIELD0',
            'HardwareUpdate': '',
            'LinkTo': '',
            'NotGenCode': '',
            'SelfClear': '',
            'SoftwareReset': 'TRUE',
            'StartBit': '0',
            'Volatile': '',
            'descrFieldName': '',
            'Description': 'New Field'
        }
    },
    'OffsetAddress': '0x0',
    'RegisterName': 'REG0',
    'descrRegName': '',
    'Flag': '0',
    'Description': 'New Register'
}

# ===================== 全局变量 =====================
dict_list = [copy.deepcopy(base_dict)]
dict_frames = []
highlighted_index = None
data_modified = False
current_file = None

# ===================== 主函数区 =====================
def show_dicts():
    dict_frames.clear()
    y_position = canvas.yview()

    for widget in dict_frame.winfo_children():
        widget.destroy()

    for idx, d in enumerate(dict_list):
        main_frame = ttk.Frame(dict_frame, padding=8, relief="groove", style="Highlight.TFrame" if idx == highlighted_index else "TFrame")
        main_frame.pack(fill="x", padx=8, pady=4)
        dict_frames.append(main_frame)

        top_row = ttk.Frame(main_frame)
        top_row.pack(fill="x", padx=5, pady=4)

        info_values = [str(v) for k, v in d.items() if k not in ["Fields", "LineNumber"]]
        info_text = "Register: " + ", ".join(info_values)
        ttk.Label(top_row, text=info_text, wraplength=1500, justify="left").pack(side="left", padx=4, expand=True)

        btn_frame = ttk.Frame(top_row)
        btn_frame.pack(side="right")
        for text, cmd in [("Edit", lambda i=idx: edit_dict(i)),
                          ("Delete", lambda i=idx: delete_dict(i)),
                          ("Add Field", lambda i=idx: add_field(i))]:
            ttk.Button(btn_frame, text=text, command=cmd).pack(side="left", padx=2)

        fields = d.get('Fields', {})
        field_container = ttk.Frame(main_frame, padding=5, relief="ridge")
        field_container.pack(fill="x", padx=5, pady=5)
        ttk.Label(field_container, text="Fields:", font=('Helvetica', 10, 'bold')).pack(anchor="w")

        for f_key, f_val in fields.items():
            field_frame = ttk.Frame(field_container, padding=4, relief="ridge")
            field_frame.pack(fill="x", padx=5, pady=3)

            for sub_key, sub_val in f_val.items():
                sub_key = str(sub_key)
                sub_val = str(sub_val)
                field_attribute_width = 6
                if sub_key == "Access": field_attribute_width = 3
                if sub_key == "BitWidth": field_attribute_width = 3
                if sub_key == "descrFieldName": field_attribute_width = 20
                if sub_key == "Description": field_attribute_width = 50
                bg_color = "#ffffff"
                label = ttk.Label(field_frame, text=sub_val, width=field_attribute_width, anchor="center",
                    background=bg_color, foreground="#333333", padding=3, relief="ridge")
                label.pack(side="left", padx=1, pady=1)

            field_btn = ttk.Frame(field_frame)
            field_btn.pack(side="right")
            ttk.Button(field_btn, text="Edit", command=lambda di=idx, fk=f_key: edit_field(di, fk)).pack(side="left", padx=2)
            ttk.Button(field_btn, text="Delete", command=lambda di=idx, fk=f_key: delete_field(di, fk)).pack(side="left", padx=2)

    root.update_idletasks()
    canvas.configure(scrollregion=canvas.bbox("all"))
    canvas.yview_moveto(y_position[0])
    combobox['values'] = [d.get("RegisterName", f"Dict{i}") for i, d in enumerate(dict_list)]

def delete_dict(index):
    #global data_modified
    if 0 <= index < len(dict_list):
        del dict_list[index]
    mark_modified() # data_modified = True
    show_dicts()

def add_new_dict():
    new_dict = copy.deepcopy(base_dict)
    open_edit_window(new_dict, lambda updated: save_new_dict(updated))

def save_new_dict(updated):
    dict_list.append(updated)
    show_dicts()

def edit_dict(index):
    open_edit_window(copy.deepcopy(dict_list[index]), lambda updated: update_existing_dict(index, updated))

def update_existing_dict(index, updated):
    dict_list[index] = updated
    show_dicts()

def add_field(index):
    def submit():
        #global data_modified
        updated = {k: e.get() for k, e in entry_fields}
        dict_list[index].setdefault('Fields', {})[str(new_key)] = updated
        win.destroy()
        mark_modified() # data_modified = True
        show_dicts()

    win = tk.Toplevel(root)
    win.title("New Field")
    form = ttk.Frame(win, padding=10)
    form.pack(fill="both", expand=True)

    new_key = len(dict_list[index].get('Fields', {})) + 1
    new_field = copy.deepcopy(base_dict['Fields'][0])
    new_field['FieldName'] = f'NEW_FIELD_{new_key}'
    new_field['LineNumber'] = new_key

    entry_fields, row = [], 0
    for k, v in new_field.items():
        ttk.Label(form, text=f"{k}:").grid(row=row, column=0, sticky="w", padx=4, pady=2)
        e = ttk.Entry(form, width=40)
        e.insert(0, v)
        e.grid(row=row, column=1, padx=4, pady=2)
        entry_fields.append((k, e))
        row += 1

    ttk.Button(form, text="Done", command=submit).grid(row=row, column=0, columnspan=2, pady=10)

def edit_field(d_idx, f_key):
    def submit():
        #global data_modified
        dict_list[d_idx]['Fields'][f_key] = {k: e.get() for k, e in entry_fields}
        win.destroy()
        mark_modified() # data_modified = True
        show_dicts()

    win = tk.Toplevel(root)
    win.title("Edit Field")
    form = ttk.Frame(win, padding=10)
    form.pack(fill="both", expand=True)

    entry_fields, row = [], 0
    for k, v in dict_list[d_idx]['Fields'][f_key].items():
        ttk.Label(form, text=f"{k}:").grid(row=row, column=0, sticky="w", padx=4, pady=2)
        e = ttk.Entry(form, width=40)
        e.insert(0, v)
        e.grid(row=row, column=1, padx=4, pady=2)
        entry_fields.append((k, e))
        row += 1

    ttk.Button(form, text="Done", command=submit).grid(row=row, column=0, columnspan=2, pady=10)

def delete_field(d_idx, f_key):
    #global data_modified
    dict_list[d_idx]['Fields'].pop(f_key, None)
    mark_modified() # data_modified = True
    show_dicts()

def open_edit_window(d, on_submit):
    win = tk.Toplevel(root)
    win.title("Edit Register")
    form = ttk.Frame(win, padding=10)
    form.pack(fill="both", expand=True)
    entry_fields, row = [], 0

    for k, v in d.items():
        if isinstance(v, dict): continue
        ttk.Label(form, text=f"{k}:").grid(row=row, column=0, sticky="w", padx=4, pady=2)
        e = ttk.Entry(form, width=40)
        e.insert(0, v)
        e.grid(row=row, column=1, padx=4, pady=2)
        entry_fields.append((k, e))
        row += 1

    def submit():
        #global data_modified
        for k, e in entry_fields:
            d[k] = e.get()
        on_submit(d)
        win.destroy()
        mark_modified() # data_modified = True

    ttk.Button(form, text="Done", command=submit).grid(row=row, column=0, columnspan=2, pady=10)

def update_title():
    """更新窗口标题"""
    title = "Register Editor"
    if current_file:
        title += f" - {current_file}"
    if data_modified:
        title += " *"
    root.title(title)

def save_to_file():
    global data_modified, current_file
    if current_file is None:
        file = filedialog.asksaveasfilename(defaultextension=".json", filetypes=[("JSON", "*.json")])
        if not file:
            return
        current_file = file
    else:
        file = current_file
    if file:
        with open(file, 'w', encoding='utf-8') as f:
            json.dump(dict_list, f, ensure_ascii=False, indent=2)
    data_modified = False
    update_title()

def load_from_file():
    global dict_list, data_modified, current_file
    if data_modified:
        result = messagebox.askyesnocancel("Warning!", "Data modified. Save before loading.")
        if result is True:
            save_to_file()
        elif result is None:
            return # Cancel

    file = filedialog.askopenfilename(filetypes=[("JSON", "*.json")])
    if file:
        with open(file, 'r', encoding='utf-8') as f:
            data = json.load(f)
            if isinstance(data, list):
                dict_list = data
                current_file = file
                data_modified = False
                update_title()
                show_dicts()

def mark_modified():
    """标记数据已修改"""
    global data_modified
    data_modified = True
    update_title()

def search_and_jump():
    global highlighted_index
    keyword = search_var.get().lower()
    for i, d in enumerate(dict_list):
        if d.get("RegisterName", "").lower() == keyword:
            highlighted_index = i
            show_dicts()
            canvas.yview_moveto(i / max(1, len(dict_list)))
            break

def jump_to_dict_by_name(event=None):
    global highlighted_index
    name = register_name_var.get()
    for i, d in enumerate(dict_list):
        if d.get("RegisterName") == name:
            highlighted_index = i
            show_dicts()
            canvas.yview_moveto(i / max(1, len(dict_list)))
            break

def on_close():
    #global data_modified
    if data_modified:
        result = messagebox.askyesnocancel("Warning!", "Data modified. Save before close.")
        if result is True:
            save_to_file()
            root.destroy()
        elif result is False:
            root.destroy()
        # else: 取消关闭
    else:
        root.destroy()

# ===================== UI 初始化 =====================
root = tk.Tk()
root.title("Register Editor")
root.geometry("1500x600")
root.protocol("WM_DELETE_WINDOW", on_close)
root.configure(background="#f7f7f7")

style = ttk.Style()
style.configure(".", font=("Helvetica", 10))
style.configure("TFrame", background="#f7f7f7")
style.configure("TLabel", background="#f7f7f7")
style.configure("TButton", padding=5)
style.configure("Highlight.TFrame", background="#d1e7dd")

search_var = tk.StringVar()
register_name_var = tk.StringVar()

# 顶部栏
top_bar = tk.Frame(root)
top_bar.configure(background="#f7f7f7")
top_bar.pack(side="top", fill="x", padx=8, pady=4)

for text, cmd in [("Add Register", add_new_dict), ("Save", save_to_file), ("Load", load_from_file)]:
    ttk.Button(top_bar, text=text, command=cmd).pack(side="left", padx=4)

search_entry = ttk.Entry(top_bar, textvariable=search_var, width=30)
search_entry.bind("<Return>", lambda e: search_and_jump())
search_entry.pack(side="left", padx=6)
ttk.Button(top_bar, text="Search", command=search_and_jump).pack(side="left")

combobox = ttk.Combobox(top_bar, values=[], textvariable=register_name_var)
combobox.pack(side="right", padx=6)
combobox.bind("<<ComboboxSelected>>", jump_to_dict_by_name)

# 中间Frame（top_bar 和 outer_frame 之间）
middle_frame = ttk.Frame(root, padding=8)
middle_frame.pack(fill="x", padx=8, pady=4)

# 第一行：两个 Combobox
first_row = ttk.Frame(middle_frame)
first_row.pack(fill="x", pady=2)
ttk.Label(first_row, text='General Info: ', justify="left").pack(side="left", padx=4)
ttk.Label(first_row, text='ModuleName', justify="left").pack(side="left", padx=4)
modulename_entry_var = tk.StringVar()
ttk.Entry(first_row, textvariable=modulename_entry_var, width=10).pack(side="left", padx=4)
ttk.Label(first_row, text='DataWidth', justify="left").pack(side="left", padx=4)
datawidth_entry_var = tk.StringVar()
ttk.Entry(first_row, textvariable=datawidth_entry_var, width=5).pack(side="left", padx=4)

## 第二行：两个 Entry
second_row = ttk.Frame(middle_frame)
second_row.pack(fill="x", pady=2)
ttk.Label(second_row, text='Default Values: ', justify="left").pack(side="left", padx=4)
ttk.Label(second_row, text='EnableBy', justify="left").pack(side="left", padx=4)
enableby_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=enableby_combo_var, width=5).pack(side="left", padx=4)
ttk.Label(second_row, text='Flag', justify="left").pack(side="left", padx=4)
flag_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=flag_combo_var, width=5).pack(side="left", padx=4)
ttk.Label(second_row, text='HardwareUpdate', justify="left").pack(side="left", padx=4)
hardwareupdate_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=hardwareupdate_combo_var, width=5).pack(side="left", padx=4)
ttk.Label(second_row, text='NotGenCode', justify="left").pack(side="left", padx=4)
notgencode_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=notgencode_combo_var, width=5).pack(side="left", padx=4)
ttk.Label(second_row, text='SelfClear', justify="left").pack(side="left", padx=4)
selfclear_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=selfclear_combo_var, width=5).pack(side="left", padx=4)
ttk.Label(second_row, text='SoftwareReset', justify="left").pack(side="left", padx=4)
softwarereset_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=softwarereset_combo_var, width=5).pack(side="left", padx=4)
ttk.Label(second_row, text='Volatile', justify="left").pack(side="left", padx=4)
volatile_combo_var = tk.StringVar()
ttk.Combobox(second_row, textvariable=volatile_combo_var, width=5).pack(side="left", padx=4)

# 外层frame+滚动
outer_frame = ttk.Frame(root)
outer_frame.pack(fill=tk.BOTH, expand=True)
canvas = tk.Canvas(outer_frame)
canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

v_scroll = ttk.Scrollbar(outer_frame, orient="vertical", command=canvas.yview)
v_scroll.pack(side="right", fill="y")
h_scroll = ttk.Scrollbar(root, orient="horizontal", command=canvas.xview)
h_scroll.pack(side="bottom", fill="x")
canvas.configure(yscrollcommand=v_scroll.set, xscrollcommand=h_scroll.set)
canvas.configure(background="#f7f7f7")

dict_frame = ttk.Frame(canvas)
dict_frame_id = canvas.create_window((0, 0), window=dict_frame, anchor="nw")

canvas.bind("<Configure>", lambda e: canvas.itemconfig(dict_frame_id, width=canvas.winfo_width()))
dict_frame.bind("<Configure>", lambda e: canvas.configure(scrollregion=canvas.bbox("all")))

if platform.system() in ['Windows', 'Darwin']:
    canvas.bind_all("<MouseWheel>", lambda e: canvas.yview_scroll(-1 * int(e.delta / 120), "units"))
    canvas.bind_all("<Shift-MouseWheel>", lambda e: canvas.xview_scroll(-1 * int(e.delta / 120), "units"))
else:
    canvas.bind_all("<Button-4>", lambda e: canvas.yview_scroll(-1, "units"))
    canvas.bind_all("<Button-5>", lambda e: canvas.yview_scroll(1, "units"))
    canvas.bind_all("<Shift-Button-4>", lambda e: canvas.xview_scroll(-1, "units"))
    canvas.bind_all("<Shift-Button-5>", lambda e: canvas.xview_scroll(1, "units"))

show_dicts()
root.mainloop()
