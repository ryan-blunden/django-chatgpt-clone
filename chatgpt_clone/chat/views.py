import json
import uuid

from django.http import HttpResponse
from django.shortcuts import render
from django.conf import settings

from . import chatgpt


def chat(request, conversation_id=None):
    if not conversation_id:
        conversation_id = uuid.uuid4()
    if request.method != "POST":
        return render(request, "chat/chat.html", {"model": settings.OPENAI_MODEL, "conversation_id": conversation_id})

    try:
        data = json.loads(request.body)

        message = data["meta"]["content"]["parts"][0]
        conversation = data["meta"]["content"]["conversation"]
        web_access = data["meta"]["content"]["web_access"]
        system_message = settings.OPENAI_SYSTEM_MESSAGE
        model = settings.OPENAI_MODEL

        response = chatgpt.chat(message, conversation, model, system_message, web_access)
        return HttpResponse(response, content_type="text/plain")
    except Exception as e:
        error_message = f"Sorry, an error occurred: {type(e).__name__} - {str(e)}"
        return HttpResponse(error_message, content_type="text/plain", status=500)
