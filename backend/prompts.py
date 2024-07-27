from openai import OpenAI
client = OpenAI()
  
assistant = client.beta.assistants.create(
  name="Relationship Dialogue",
  instructions="Write a creative dialogue to move the story between lovers forward.",
  tools=[{"type": "function",
           "function" : {
            "name": "tone",
            "description": "sends a prompt to Agent 1 to forward the story positively",
             },
            "function" : {
                "name": "color",
                "description": "Return a hex color code based on the tone of the dialogue"
            },
             "required": ["tone", "color"]}],
  model="gpt-3.5-turbo-0125",
)