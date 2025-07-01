import tkinter as tk
from tkinter import ttk, filedialog
import json
import copy
import platform

# 原始 dict
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
    #'IncrAddress': '',
    'OffsetAddress': '0x0',
    'RegisterName': 'REG0',
    'descrRegName': '',
    'Flag': '0',
    'Description': 'New Register'
}

# 存放所有 dict 的列表
dict_list = [copy.deepcopy(base_dict)]

dict_frames = []  # 存放每个dict对应的Frame对象
highlighted_index = None  # 当前高亮的dict索引

def show_dicts():
    dict_frames.clear() # 清空旧的 frame 列表

    # Step 1: 记录当前垂直滚动位置
    y_position = canvas.yview()

    """在主界面显示所有 dict 的简化信息，并添加各个操作按钮"""
    for widget in dict_frame.winfo_children():
        widget.destroy()

    for idx, d in enumerate(dict_list):
        main_frame = ttk.Frame(dict_frame, padding=5, relief="ridge")
        main_frame.pack(fill="x", padx=5, pady=3)

        dict_frames.append(main_frame)  # 保存 frame 引用

        # 如果当前是被高亮项，则设置背景色
        bg_color = "#fffacd" if idx == highlighted_index else None
        if bg_color:
            main_frame.configure(style=f"Highlight.TFrame")
        else:
            main_frame.configure(style="TFrame")  # 恢复默认样式

        # 上半部分：非 Fields 信息 + 操作按钮（在同一行）
        top_row_frame = ttk.Frame(main_frame)
        top_row_frame.pack(side="top", fill="x", padx=5, pady=5)

        # 拼接非 Fields 的 value 信息（在一行中）
        info_values = [str(v) for k, v in d.items() if k not in ["Fields", "LineNumber"]]
        info_text = "Register: " + ", ".join(info_values)
        info_label = ttk.Label(top_row_frame, text=info_text, wraplength=1500, justify="left")
        info_label.pack(side="left", padx=5, anchor="w", expand=True)

        # 按钮们放在右侧
        btn_frame = ttk.Frame(top_row_frame)
        btn_frame.pack(side="right", padx=5)

        ttk.Button(btn_frame, text="Edit", command=lambda i=idx: edit_dict(i)).pack(side="left", padx=2)
        ttk.Button(btn_frame, text="Delete", command=lambda i=idx: delete_dict(i)).pack(side="left", padx=2)
        ttk.Button(btn_frame, text="Add Field", command=lambda i=idx: add_field(i)).pack(side="left", padx=2)

        # Fields 区域
        fields_frame = ttk.Frame(main_frame, relief="groove", padding=5)
        fields_frame.pack(side="top", fill="x", padx=5, pady=5)
        ttk.Label(fields_frame, text="Fields:", font=('Arial', 10, 'bold')).pack(anchor="w")

        for f_key, f_value in d.get('Fields', {}).items():
            field_frame = ttk.Frame(fields_frame, padding=3, relief="ridge")
            field_frame.pack(fill="x", padx=5, pady=3)

            # 只显示子 dict 的 value（不显示 key）
            val_list = [str(v) for v in f_value.values() if f_key not in ["LineNumber"]]
            field_info = ", ".join(val_list)
            ttk.Label(field_frame, text=field_info, wraplength=600, justify="left").pack(side="left", padx=5)

            # 编辑和删除按钮（并排显示）
            btn_field_frame = ttk.Frame(field_frame)
            btn_field_frame.pack(side="right", padx=5)
            ttk.Button(btn_field_frame, text="Edit",
                       command=lambda di=idx, fk=f_key: edit_field(di, fk)).pack(side="left", padx=2)
            ttk.Button(btn_field_frame, text="Delete",
                       command=lambda di=idx, fk=f_key: delete_field(di, fk)).pack(side="left", padx=2)

    root.update_idletasks()
    canvas.configure(scrollregion=canvas.bbox("all"))
    canvas.yview_moveto(y_position[0])

    # 更新下拉菜单内容
    register_names = [d.get("RegisterName", f"Dict{i}") for i, d in enumerate(dict_list)]
    combobox['values'] = register_names

def delete_dict(index):
    """删除指定的 dict"""
    if 0 <= index < len(dict_list):
        del dict_list[index]
    show_dicts()


def add_new_dict():
    """新建一个和 base_dict 结构一致的 dict"""
    new_dict = copy.deepcopy(base_dict)
    open_edit_window(new_dict, lambda updated_dict: save_new_dict(updated_dict))


def save_new_dict(updated_dict):
    """保存新创建的 dict 并刷新显示"""
    dict_list.append(updated_dict)
    show_dicts()


def edit_dict(index):
    """编辑已有的 dict"""
    existing_dict = copy.deepcopy(dict_list[index])
    open_edit_window(existing_dict, lambda updated_dict: update_existing_dict(index, updated_dict))


def update_existing_dict(index, updated_dict):
    """更新已有 dict 并刷新显示"""
    dict_list[index] = updated_dict
    show_dicts()


def add_field(index):
    """为指定 dict 的 Fields 添加新的 Field"""
    edit_window = tk.Toplevel(root)
    edit_window.title("New Field")

    form_frame = ttk.Frame(edit_window, padding=10)
    form_frame.pack(fill=tk.BOTH, expand=True)

    # 获取该 dict 中的 Fields
    existing_fields = dict_list[index].get('Fields', {})
    #new_field_key = max(existing_fields.keys()) + 1 if existing_fields else 1
    new_field_key = len(existing_fields.keys()) + 1

    # 新 Field 的初始结构（与 base_dict 内 Field 结构相同）
    new_field = {
        'Access': 'RW',
        'BitWidth': '32',
        'DefaultValue': '0',
        'Description': '',
        'EnableBy': '',
        'FieldName': f'NEW_FIELD_{new_field_key}',
        'HardwareUpdate': '',
        'LineNumber': new_field_key,
        'LinkTo': '',
        'NotGenCode': '',
        'SelfClear': '',
        'SoftwareReset': 'TRUE',
        'StartBit': '0',
        'Volatile': '',
        'descrFieldName': ''
    }

    entry_fields = []
    row = 0
    for key, value in new_field.items():
        #label = ttk.Label(form_frame, text=f"{key}(Default: {value}):")
        label = ttk.Label(form_frame, text=f"{key}:")
        label.grid(row=row, column=0, sticky="w", padx=5, pady=2)
        entry = ttk.Entry(form_frame, width=40)
        entry.insert(0, str(value))
        entry.grid(row=row, column=1, padx=5, pady=2)
        entry_fields.append((key, entry))
        row += 1

    def submit_field():
        updated_field = {key: entry.get() for key, entry in entry_fields}
        # 确保 'Fields' 键存在
        if 'Fields' not in dict_list[index]:
            dict_list[index]['Fields'] = {}
        dict_list[index]['Fields'][str(new_field_key)] = updated_field
        edit_window.destroy()
        show_dicts()

    submit_btn = ttk.Button(form_frame, text="Done", command=submit_field)
    submit_btn.grid(row=row, column=0, columnspan=2, pady=10)


def edit_field(dict_index, field_key):
    """编辑指定 dict 内的某个 Field"""
    edit_window = tk.Toplevel(root)
    edit_window.title("Edit Field")

    form_frame = ttk.Frame(edit_window, padding=10)
    form_frame.pack(fill=tk.BOTH, expand=True)

    field_data = dict_list[dict_index]['Fields'][field_key]

    entry_fields = []
    row = 0
    for key, value in field_data.items():
        #label = ttk.Label(form_frame, text=f"{key}(Current:{value}):")
        label = ttk.Label(form_frame, text=f"{key}:")
        label.grid(row=row, column=0, sticky="w", padx=5, pady=2)
        entry = ttk.Entry(form_frame, width=40)
        entry.insert(0, str(value))
        entry.grid(row=row, column=1, padx=5, pady=2)
        entry_fields.append((key, entry))
        row += 1

    def submit_edit():
        updated_field = {key: entry.get() for key, entry in entry_fields}
        dict_list[dict_index]['Fields'][field_key] = updated_field
        edit_window.destroy()
        show_dicts()

    submit_btn = ttk.Button(form_frame, text="Done", command=submit_edit)
    submit_btn.grid(row=row, column=0, columnspan=2, pady=10)


def delete_field(dict_index, field_key):
    """删除指定 dict 内的某个 Field"""
    if field_key in dict_list[dict_index].get('Fields', {}):
        del dict_list[dict_index]['Fields'][field_key]
    show_dicts()


def open_edit_window(target_dict, on_submit):
    """通用的 dict 编辑窗口（用于新增和修改整个 dict）"""
    edit_window = tk.Toplevel(root)
    edit_window.title("Edit Register")

    form_frame = ttk.Frame(edit_window, padding=10)
    form_frame.pack(fill=tk.BOTH, expand=True)

    entry_fields = []
    row = 0

    def add_entries(d, keys=[]):
        nonlocal row
        for key, value in d.items():
            if isinstance(value, dict):
                #add_entries(value, keys + [key])
                pass
            else:
                #label = ttk.Label(form_frame, text=" -> ".join(map(str, keys + [key])) + f"(Old Value:{value}):")
                label = ttk.Label(form_frame, text=" -> ".join(map(str, keys + [key])))
                label.grid(row=row, column=0, sticky="w", padx=5, pady=2)
                entry = ttk.Entry(form_frame, width=40)
                entry.insert(0, str(value))
                entry.grid(row=row, column=1, padx=5, pady=2)
                entry_fields.append((keys + [key], entry))
                row += 1

    add_entries(target_dict)

    def submit_form():
        updated_dict = copy.deepcopy(target_dict)
        for key_path, entry in entry_fields:
            current = updated_dict
            for k in key_path[:-1]:
                current = current[k]
            current[key_path[-1]] = entry.get()
        on_submit(updated_dict)
        edit_window.destroy()

    submit_btn = ttk.Button(form_frame, text="Done", command=submit_form)
    submit_btn.grid(row=row, column=0, columnspan=2, pady=10)

def save_to_file():
    file_path = filedialog.asksaveasfilename(defaultextension=".json", filetypes=[("JSON", "*.json")])
    if file_path:
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(dict_list, f, ensure_ascii=False, indent=2)

def load_from_file():
    file_path = filedialog.askopenfilename(filetypes=[("JSON", "*.json")])
    if file_path:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
            if isinstance(data, list):
                global dict_list
                dict_list = data
                show_dicts()

def search_and_jump():
    global highlighted_index
    keyword = search_var.get().lower()
    for i, d in enumerate(dict_list):
        #if keyword in str(d).lower():
        if d.get("RegisterName").lower() == keyword:
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

# 主窗口
root = tk.Tk()
root.title("Register Editor")
root.geometry("1000x600")  # 宽1000，高600

style = ttk.Style()
#style.configure("TFrame", background="SytemButtonFace")  # 默认样式
style.configure("TFrame")  # 默认样式
style.configure("Highlight.TFrame", background="#fffacd")  # 高亮样式（淡黄）

# 搜索和跳转控件
search_var = tk.StringVar()
register_name_var = tk.StringVar()

# UI 顶部操作区
top_bar = ttk.Frame(root)
top_bar.pack(side="top", fill="x", padx=5, pady=2)

ttk.Button(top_bar, text="Add Register", command=lambda: add_new_dict()).pack(side="left", padx=2)
ttk.Button(top_bar, text="Save", command=save_to_file).pack(side="left", padx=2)
ttk.Button(top_bar, text="Load", command=load_from_file).pack(side="left", padx=2)
search_entry = ttk.Entry(top_bar, textvariable=search_var, width=30)
search_entry.bind("<Return>", lambda event: search_and_jump())
search_entry.pack(side="left", padx=5)
ttk.Button(top_bar, text="Search", command=search_and_jump).pack(side="left")

register_names = [d.get("RegisterName", f"Dict{i}") for i, d in enumerate(dict_list)]
combobox = ttk.Combobox(top_bar, values=register_names, textvariable=register_name_var)
combobox.pack(side="right", padx=5)
combobox.bind("<<ComboboxSelected>>", jump_to_dict_by_name)

# 创建外层 Frame 包裹 canvas + scrollbar
outer_frame = ttk.Frame(root)
outer_frame.pack(fill=tk.BOTH, expand=True)

# 创建 Canvas
canvas = tk.Canvas(outer_frame)
canvas.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

# 创建垂直 & 水平 Scrollbar
v_scroll = ttk.Scrollbar(outer_frame, orient=tk.VERTICAL, command=canvas.yview)
v_scroll.pack(side=tk.RIGHT, fill=tk.Y)

h_scroll = ttk.Scrollbar(root, orient=tk.HORIZONTAL, command=canvas.xview)
h_scroll.pack(side=tk.BOTTOM, fill=tk.X)

# 配置 Scrollbar 控制 Canvas
canvas.configure(yscrollcommand=v_scroll.set, xscrollcommand=h_scroll.set)

# 创建 Frame 用于容纳内容，并挂到 Canvas 上
dict_frame = ttk.Frame(canvas)
dict_frame_id = canvas.create_window((0, 0), window=dict_frame, anchor="nw")

# 在内容变化或尺寸变化时，调整 scrollregion 和 frame 尺寸
def configure_canvas(event):
    canvas.configure(scrollregion=canvas.bbox("all"))
    # 自动适配宽度（当窗口被最大化时）
    canvas.itemconfig(dict_frame_id, width=canvas.winfo_width())

canvas.bind("<Configure>", lambda e: canvas.itemconfig(dict_frame_id, width=canvas.winfo_width()))

dict_frame.bind("<Configure>", configure_canvas)

# 鼠标滚轮支持（不同平台略有不同）
def _on_mousewheel(event):
    if platform.system() == 'Windows':
        canvas.yview_scroll(-1 * int(event.delta / 120), "units")
    elif platform.system() == 'Darwin':  # macOS
        canvas.yview_scroll(-1 * int(event.delta), "units")
    else:  # Linux, use Button-4 and Button-5
        pass  # handled separately below

def _on_shift_mousewheel(event):
    if platform.system() == 'Windows':
        canvas.xview_scroll(-1 * int(event.delta / 120), "units")
    elif platform.system() == 'Darwin':
        canvas.xview_scroll(-1 * int(event.delta), "units")
    else:
        pass  # handled separately below

# Windows 和 macOS 支持滚动
if platform.system() in ['Windows', 'Darwin']:
    canvas.bind_all("<MouseWheel>", _on_mousewheel)
    canvas.bind_all("<Shift-MouseWheel>", _on_shift_mousewheel)
else:  # Linux 处理方式
    canvas.bind_all("<Button-4>", lambda e: canvas.yview_scroll(-1, "units"))
    canvas.bind_all("<Button-5>", lambda e: canvas.yview_scroll(1, "units"))
    canvas.bind_all("<Shift-Button-4>", lambda e: canvas.xview_scroll(-1, "units"))
    canvas.bind_all("<Shift-Button-5>", lambda e: canvas.xview_scroll(1, "units"))

#ttk.Button(root, text="Add Register", command=add_new_dict).pack(pady=5) #move to top_bar

show_dicts()

root.mainloop()
