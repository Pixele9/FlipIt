import asyncio
import json
from django.contrib.auth import get_user_model
from channels.consumer import AsyncConsumer
from channels.db import database_sync_to_async

class GameConsumer(AsyncConsumer):
    async def websocket_connect(self, event):
        await self.send({
            "type":"websocket.accept",
        })

        usuario = self.scope['user']
        codigo = self.scope['url_route']['kwargs']['codigo']
        print(codigo)
        print(usuario)
        # await asyncio.sleep(10)
        # await self.send({
        #     "type":"websocket.close",
        # })


        await self.send({
            "type":"websocket.send",
            "text": "user",
        })

    async def websocket_receive(self, event):
        texto = event['text'].replace(u'\xa0', u' ')
        await self.send({
            "type":"websocket.send",
            "text": texto,
        })

    
    async def websocket_disconnect(self, event):
        print("Deconectado", event) 