# Chat Application

This is a very simple Chat application written in Python. 
Backend servers are written in Python using Bottle framework.
The project built according to the design diagram in `docs` folder.

![alt text](https://github.com/AlmogAlon/chatapp/blob/main/docs/design.png?raw=true)


it uses MySQL (sqlalchemy as ORM) as database, and Redis as cache and message broker.

Project Services are:
- Notification service
  - Exposes a RESTFUL API for sending notifications to users.
  - Stores notifications in a database.

- Socket service
  - Bottle application for handling websocket connections to communicate with clients.

## Requirements
- python3.10
- Docker (optional)
- docker-compose version 1.29.2

## Installation

To run the services using docker-compose (recommended):
- execute these commands: 

```bash
  cd chatapp
  ./docker/recreate_images.sh
```

To run the services locally:
```bash
  cd chatapp/services
  ./rebuild_env.bat
```
- open IDE from the root folder of the service
- configure python interpreter to use: `chatapp/services/venv/bin/python`

```bash
  cd chatapp/services/SERVICE_NAME
  python main.py
```


## Notification Service 
### API Reference

#### Send a new message

```bash
  curl --location --request POST '127.0.0.1:1337/api/notification' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username": "test",
    "message": "test message"
    "room_name": "test_room"
}'
```

| Parameter   | Type     | Description  |
|:------------| :------- |:-------------|
| `username`  | `Str` | **Required** |
| `message`   | `Str` | **Required** |
| `room_name` | `Str` | **Optional** |


## Test Client tool

connects to the socket service and waits for messages.
it can also send messages to the socket service.

```bash
  cd chatapp/services/socket
  python test_client.py
```

```bash
  cd chatapp/services/tools
  python client.py --username=david --message
```
| Parameter  | Type     | Description                                    |
|:-----------| :------- |:-----------------------------------------------|
| `username` | `Str` | **Required** fetch messages for the given user |
| `message`  |  | **Optional** prompt message input              |
| `room`     |  | **Optional** room name                         |

To run the client in docker:
- execute these commands: 

```bash
  cd chatapp
  docker build . -f docker/client/Dockerfile -t chat-app:client
  docker run --network="host" chat-app:client --username david
```
