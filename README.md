# conn - SSH Connection Manager for Fish Shell

`conn` is a powerful and lightweight Fish shell plugin designed to simplify the management of SSH connections. It provides a convenient command-line interface to add, list, and connect to your servers effortlessly.

## Features

*   **Server Management**: Easily add and list your SSH servers.
*   **Dynamic Hostnames**: Use placeholders like `{{id}}` in hostnames for dynamic server connections. For example, connect to `{{id}}.example.com` by specifying `--id=server1`.
*   **Customizable Connections**: Override the saved username and pass extra arguments to SSH on the fly.
*   **Tab Completion**: `conn` supports tab completion for server names, making it faster to connect to your servers.
*   **Simple Configuration**: Server data is stored in a clean, human-readable format.

## Requirements

*   [Fish shell](https://fishshell.com/)

## Installation

You can install `conn` using a Fish shell plugin manager like [Fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install zadewu/conn
```

## Usage

### Connecting to a server

To connect to a server, simply use the `conn` command followed by the server name:

```fish
conn <server_name>
```

### Adding a new server

Add a new server to your list with the `conn add` command:

```fish
conn add -n <name> -u <user> -h <host>
```

### Listing all servers

To see a list of all your saved servers, use `conn list` or `conn ls`:

```fish
conn list
```

## Options

`conn` supports several options to customize your SSH connections:

*   `--id=<value>`: Replace the `{{id}}` placeholder in the hostname with the specified value.
*   `--user=<username>`: Use a different username for the connection, overriding the saved one.
*   `--extra-args='<ssh_options>'`: Pass additional arguments to the SSH command. For example, to forward a port, you can use `--extra-args='-L 8080:localhost:8080'`.

## Configuration

Your server connection data is stored in a simple pipe-separated file at `$XDG_DATA_HOME/conn/data` (or `$HOME/.local/share/conn/data` if `$XDG_DATA_HOME` is not set).

The format for each line is: `name|user|host`

## Examples

### Adding a server

To add a server named `myserver`, with the user `admin` and host `myserver.com`, run:

```fish
conn add -n myserver -u admin -h myserver.com
```

### Connecting to a server

To connect to the server you just added:

```fish
conn myserver
```

### Using dynamic hostnames

If you have a server with a dynamic hostname like `{{id}}.dev.example.com`, you can add it as follows:

```fish
conn add -n dev-server -u developer -h '{{id}}.dev.example.com'
```

Now, you can connect to `prod.dev.example.com` using the `--id` option:

```fish
conn dev-server --id=prod
```