    Count Dooku :)

    Register code generator.

    RTL designers maintain registers in .xlsx spreadsheet,
        then covert it to verilog/systemverilog RTL code by calling the script.
    The script also helps other function teams to covert spreadsheet to UVM RAL models for verification,
        or to HTML/Confluence pages for documenting,
        or to C header files (.h) for firmware development.
    
    Follow MIT license.

    The spreadsheet can be .xlsx, .xls or .csv format.

# Note

    The .xlsx spreadsheet is converted to .csv file using https://github.com/dilshod/xlsx2csv.
    It's recommeded to use 0.8.2 of xlsx2csv.

# Usage, argument
| Argument | Description |
| - | - |
| --debug | Print more message for debug purpose. |
| -h | Print help message. |
| -rtl | Generate RTL code of register. |
| -flag | An extra infomation bit of register. `For RTL generation only.` |
| -ral | Generate UVM RAL code for verfication engineer. |
| -cheader | Generate C header file of register defination and address. |
| -html | Generate HTML page for documenting. |
| -confluence | Generate Confluence pages by calling its API. `Not support yet.` |
| -input [spreadsheet] | The spreadsheet file. `More than one spreadsheet can be handled.`|
| -output [path_of_folder] | The folder of generated files. |
## Examples

    TBA

# Block registers defination spreadsheet

    TBA

# Top level register map spreadsheet

    TBA