# Start a Process with Assistant and input file

This example demonstrates how an attended Assistant run is capable of picking up a
local file and uploading it as an input Work Item to start an unattended Process in
Control Room with.

## Setup

Ensure the following:
1. A Control Room API key with enough rights is present in the "process_cr" Vault
   store within the `api_key` field.
2. You know and configure in the robot code both the Workspace and the Process IDs.

## Tasks

### `Select And Upload Excel To Control Room`

Pick an Excel file, then create a Work Item to start a new Process Run with it as
input.

### `Process Input Excel File In Control Room`

Process the received input Work Item containing the previously selected Excel file.
