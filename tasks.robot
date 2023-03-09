*** Settings ***
Documentation       Assistant example with which you pick an Excel file and start an
...    unattended Process in Control Room for processing it.

Library    RPA.Assistant
Library    RPA.Excel.Files
Library    RPA.FileSystem
Library    RPA.Robocorp.Process
Library    RPA.Robocorp.Vault
Library    RPA.Robocorp.WorkItems


*** Variables ***
${WORKSPACE_ID}    7
${PROCESS_ID}    43e4faff-854e-43b3-9c21-3594d757167f


*** Keywords ***
Initialize Process Library
    ${secret} =    Get Secret    process_cr
    Set Credentials    ${WORKSPACE_ID}    ${PROCESS_ID}    ${secret}[api_key]


*** Tasks ***
Select And Upload Excel To Control Room
    [Documentation]    Pick an Excel file, then create a Work Item to start a new
    ...    Process Run with it as input.
    [Setup]   Initialize Process Library

    Add Heading    Start Process with Excel input
    ${source} =    Absolute Path    devdata${/}work-items-in${/}excel
    Add File Input   excel   label=Excel file    source=${source}   file_type=xls,xlsx
    ${result} =    Ask User
    ${excel_file} =    Set Variable    ${result.excel}[${0}]

    ${item_id} =    Create Input Work Item    files=${excel_file}
    Start Configured Process    config_type=work_items    extra_info=${item_id}


Process Input Excel File In Control Room
    [Documentation]    Process the received input Work Item containing the previously
    ...    selected Excel file.

    @{files} =    Get Work Item Files    *.xls*    dirname=${OUTPUT_DIR}
    Open Workbook    ${files}[${0}]
    ${table} =    Read Worksheet As Table    header=${True}
    Log    Table: ${table}

    [Teardown]    Close Workbook
