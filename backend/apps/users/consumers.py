from channels.generic.websocket import WebsocketConsumer
from django.contrib.auth import get_user_model
from asgiref.sync import async_to_sync
import asyncio
import json
# from channels.consumer import SyncConsumer
# from channels.consumer import AsyncConsumer

class GameConsumer(WebsocketConsumer):
    room_group_name = ''
    userID = 0

    def connect(self):
        self.userID = self.scope['session'].get('member_id')
        self.room_name = self.scope['url_route']['kwargs']['codigo']
        self.room_group_name = self.room_name

        print(self.room_group_name)
        print(self.userID)

        async_to_sync(self.channel_layer.group_add)(
            self.room_group_name,
            self.channel_name
        )

        self.accept()

    def receive(self, text_data):
        data = json.loads(text_data)
        codigo = self.scope['url_route']['kwargs']['codigo']

        self.send_group_message(codigo, data['message'])

    
    def disconnect(self, close_code):
        async_to_sync(self.channel_layer.group_discard)(
            self.room_group_name,
            self.channel_name
        )

    def send_group_message(self, group_name, message):
        async_to_sync(self.channel_layer.group_send)(
            f'{group_name}', # Specify intented group
            {
                'type': 'channel_message',
                'message': message
            }
        )

    def channel_message(self, event):
        message = event['message']

        # Send message to WebSocket
        self.send(text_data=json.dumps({
            'message': message
        }))
    
    # async def connect(self, event):
    #     await self.accept()
    #     self.rooms = set()

    # async def receive_json(self, content):
    #     command = content.get("command", None)
    #     try:
    #         if command == "join":
    #             await self.join_room(content["room"])
    #         elif command == "leave":
    #             await self.leave_room(content["room"])
    #         elif command == "send":
    #             await self.send_room(content["room"], content["message"])
    #     except ClientError as e:
    #         await self.send_json({"error": e.code})

    # async def disconnect(self, code):
    #     for room_id in list(self.rooms):
    #         try:
    #             await self.leave_room(room_id)
    #         except ClientError:
    #             pass

    # async def join_room(self, room_id):
    #     room = await get_room_or_error(room_id, self.scope["user"])
    #     self.rooms.add(room_id)
    #     await self.channel_layer.group_add(
    #         room.group_name,
    #         self.channel_name,
    #     )
    #     await self.send_json({
    #         "join": str(room.id),
    #         "title": room.title,
    #     })

    # async def leave_room(self, room_id):
    #     room = await get_room_or_error(room_id, self.scope["user"])
    #     self.rooms.discard(room_id)
    #     await self.channel_layer.group_discard(
    #         room.group_name,
    #         self.channel_name,
    #     )
    #     await self.send_json({
    #         "leave": str(room.id),
    #     })

    # async def game_message(self, event):
    #     """
    #     Called when someone has messaged our chat.
    #     """
    #     # Send a message down to the client
    #     await self.send_json(
    #         {
    #             "msg_type": settings.MSG_TYPE_MESSAGE,
    #             "room": event["room_id"],
    #             "username": event["username"],
    #             "message": event["message"],
    #         },
    #     )web_socket_channel