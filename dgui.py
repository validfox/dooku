import tkinter as tk
from tkinter import ttk
import copy

# 原始 dict
base_dict = {
    'Description': '',
    'Fields': {
        12: {
            'Access': 'RW',
            'BitWidth': '32',
            'DefaultValue': '0',
            'Description': '',
            'EnableBy': '',
            'FieldName': 'USR',
            'HardwareUpdate': '',
            'LineNumber': 12,
            'LinkTo': '',
            'NotGenCode': '',
            'SelfClear': '',
            'SoftwareReset': 'TRUE',
            'StartBit': '0',
            'Volatile': '',
            'descrFieldName': ''
        }
    },
    'Flag': '0',
    'IncrAddress': '',
    'LineNumber': 11,
    'OffsetAddress': '0x4',
    'RegisterName': 'RWREG',
    'descrRegName': ''
}

# 存放所有 dict 的列表
dict_list = [copy.deepcopy(base_dict)]


def show_dicts():
    """在主界面显示所有 dict 的详细信息，并添加各个操作按钮"""
    for widget in dict_frame.winfo_children():
        widget.destroy()

    # 对于每个 dict
    for idx, d in enumerate(dict_list):
        main_frame = ttk.Frame(dict_frame, padding=5, relief="ridge")
        main_frame.pack(fill="x", padx=5, pady=3)

        # 显示整个 dict 的文本信息
        text = tk.Text(main_frame, height=10, width=80, wrap="word")
        text.insert(tk.END, f"Dict {idx + 1}:\n{d}")
        text.config(state="disabled")
        text.pack(side="top", padx=5, pady=5)

        # 按钮框架（用于修改、删除整个 dict 及添加 Field）
        btn_frame = ttk.Frame(main_frame)
        btn_frame.pack(side="top", fill="x", padx=5, pady=2)

        ttk.Button(btn_frame, text="修改 dict", command=lambda i=idx: edit_dict(i)).pack(side="left", padx=2)
        ttk.Button(btn_frame, text="删除 dict", command=lambda i=idx: delete_dict(i)).pack(side="left", padx=2)
        ttk.Button(btn_frame, text="添加 Field", command=lambda i=idx: add_field(i)).pack(side="left", padx=2)

        # 显示 Fields 内部各 Field 的信息及对应操作按钮
        fields_frame = ttk.Frame(main_frame, relief="groove", padding=5)
        fields_frame.pack(side="top", fill="x", padx=5, pady=5)
        ttk.Label(fields_frame, text="Fields:", font=('Arial', 10, 'bold')).pack(anchor="w")

        for f_key, f_value in d.get('Fields', {}).items():
            field_frame = ttk.Frame(fields_frame, padding=3, relief="ridge")
            field_frame.pack(fill="x", padx=5, pady=3)

            # 显示 Field 信息
            field_info = f"Key: {f_key}  Value: {f_value}"
            ttk.Label(field_frame, text=field_info, wraplength=500).pack(side="left", padx=5)

            # 编辑和删除 Field 按钮
            btn_field_frame = ttk.Frame(field_frame)
            btn_field_frame.pack(side="right", padx=5)
            ttk.Button(btn_field_frame, text="编辑 Field", 
                       command=lambda di=idx, fk=f_key: edit_field(di, fk)).pack(side="top", padx=2, pady=1)
            ttk.Button(btn_field_frame, text="删除 Field", 
                       command=lambda di=idx, fk=f_key: delete_field(di, fk)).pack(side="top", padx=2, pady=1)

    root.update_idletasks()


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
    edit_window.title("添加新 Field")

    form_frame = ttk.Frame(edit_window, padding=10)
    form_frame.pack(fill=tk.BOTH, expand=True)

    # 获取该 dict 中的 Fields
    existing_fields = dict_list[index].get('Fields', {})
    new_field_key = max(existing_fields.keys()) + 1 if existing_fields else 1

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
        label = ttk.Label(form_frame, text=f"{key}（默认：{value}）:")
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
        dict_list[index]['Fields'][new_field_key] = updated_field
        edit_window.destroy()
        show_dicts()

    submit_btn = ttk.Button(form_frame, text="提交", command=submit_field)
    submit_btn.grid(row=row, column=0, columnspan=2, pady=10)


def edit_field(dict_index, field_key):
    """编辑指定 dict 内的某个 Field"""
    edit_window = tk.Toplevel(root)
    edit_window.title("编辑 Field")

    form_frame = ttk.Frame(edit_window, padding=10)
    form_frame.pack(fill=tk.BOTH, expand=True)

    field_data = dict_list[dict_index]['Fields'][field_key]

    entry_fields = []
    row = 0
    for key, value in field_data.items():
        label = ttk.Label(form_frame, text=f"{key}（当前：{value}）:")
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

    submit_btn = ttk.Button(form_frame, text="提交", command=submit_edit)
    submit_btn.grid(row=row, column=0, columnspan=2, pady=10)


def delete_field(dict_index, field_key):
    """删除指定 dict 内的某个 Field"""
    if field_key in dict_list[dict_index].get('Fields', {}):
        del dict_list[dict_index]['Fields'][field_key]
    show_dicts()


def open_edit_window(target_dict, on_submit):
    """通用的 dict 编辑窗口（用于新增和修改整个 dict）"""
    edit_window = tk.Toplevel(root)
    edit_window.title("编辑字典")

    form_frame = ttk.Frame(edit_window, padding=10)
    form_frame.pack(fill=tk.BOTH, expand=True)

    entry_fields = []
    row = 0

    def add_entries(d, keys=[]):
        nonlocal row
        for key, value in d.items():
            if isinstance(value, dict):
                add_entries(value, keys + [key])
            else:
                label = ttk.Label(form_frame, text=" -> ".join(map(str, keys + [key])) + f"（原值：{value}）:")
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

    submit_btn = ttk.Button(form_frame, text="提交", command=submit_form)
    submit_btn.grid(row=row, column=0, columnspan=2, pady=10)


# 主窗口
root = tk.Tk()
root.title("Dict 显示、编辑与管理示例")

dict_frame = ttk.Frame(root, padding=10)
dict_frame.pack(fill=tk.BOTH, expand=True)

ttk.Button(root, text="添加新字典", command=add_new_dict).pack(pady=5)

show_dicts()

root.mainloop()

