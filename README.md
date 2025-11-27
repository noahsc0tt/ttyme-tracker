# Random TTY Screensaver

Track your time usage with this [timewarrior](https://github.com/GothenburgBitFactory/timewarrior) wrapper.

## Requirements

- [timewarrior](https://github.com/GothenburgBitFactory/timewarrior)
- [fzf](https://github.com/junegunn/fzf)

## Installation

This is just a bash script, so:

1. Clone this repository
   ```sh
   git clone https://github.com/noahsc0tt/ttyme-tracker
   cd ttyme-tracker
   ```

2. Make the script executable

    ```sh
    chmod +x ttyme-tracker.sh
    ```

3. Put it somewhere on your path
   ```sh
    cp ttyme-tracker.sh /usr/local/bin/ttyme
    ```
    The filename should be the command you would like to invoke the tool with

## Usage

  Run the name of the executable
  ```sh
  ttyme
  ```

  The tag list to choose from can be changed by modifying the `$TAGS` array in `ttyme-tracker.sh`
