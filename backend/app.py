from flask import Flask, request, jsonify
import os
from dotenv import load_dotenv
from openai import OpenAI
import openai

load_dotenv()

client = OpenAI()

# Set your OpenAI API key from environment variable
openai.api_key = os.getenv('OPENAI_API_KEY')

# Ensure the API key is available
if not openai.api_key:
    raise ValueError("The API key is not set. Please set the OPENAI_API_KEY environment variable.")

app = Flask(__name__)

base_prompt = """
    You are a storyteller telling a continuous story about two lovers in the form of a back-and-forth dialogue where a character named Romeo is 
    is trying to convince another character named Juliet to get back together. By the end of the dialogue, the characters should come to a decision 
    that they [do / do not] get back together. Throughout the dialogue, Juliet wavers between getting back together and breaking up.

    Throughout this conversation, you will be prompted to forward the story either positively or negatively. With each prompt, forward the story as instructed in the form of 
    two lines of dialogue between Romeo and Juliet. And then analyze the tone of the "juliet_dialogue" and provide 
    a color hex code that represents the tone of the dialogue. Try to use a wide spectrum of colors and to not repeat colors.

    Your response should be formatted as a JSON body as follows:
    {"romeo_dialogue": "Please, just give me a chance. I’ve been thinking a lot, and I really want to explain myself.","juliet_dialogue": "Explain what, exactly? You hurt me, and it’s not something I can just forget.","color_hex_code": "#FF0000"}
    """

# In-memory store for session histories
session_histories = {}

def generate_dialogue(session_id, prompt, session_histories):
    # Append the new user prompt to the session history
    session_histories[session_id].append({"role": "user", "content": prompt})

    # Combine the base prompt with the session history if it's the first interaction, otherwise just use the session history
    if len(session_histories[session_id]) == 1:
        messages = [{"role": "system", "content": base_prompt}] + session_histories[session_id]
    else:
        messages = session_histories[session_id]

    # API Call
    response = client.chat.completions.create(model="gpt-3.5-turbo-0125",  # Use the appropriate GPT-3.5 model name
    messages=messages,
    max_tokens=200,
    temperature=0.7)

    # Extract the JSON response
    dialogue_response = response.choices[0].message.content

    # Append the response to the session history
    session_histories[session_id].append({"role": "assistant", "content": dialogue_response})

    return dialogue_response


'''
Example JSON body for POST requests
{
    "session_id": 0
}
'''

# Root endpoint to initialize a new session
@app.route('/', methods=['GET'])
def start_game_session():
    session_id = len(session_histories) + 1
    session_histories[session_id] = []
    print("session_histories: ", session_histories)
    return jsonify({"session_id": session_id})

# Forward the story positively
@app.route('/positiveStory', methods=['GET'])
def progress_story_positively():
    #data = request.get_json()
    #session_id = data['session_id']

    session_id = 1

    if session_id not in session_histories:
        return jsonify({"error": "Session ID not found. Please start a new session."}), 400
    prompt = """Forward the story positively. Your response should be formatted as a JSON body as follows and only as follows:{"romeo_dialogue": "Please, just give me a chance. I’ve been thinking a lot, and I really want to explain myself.","juliet_dialogue": "Explain what, exactly? You hurt me, and it’s not something I can just forget.","color_hex_code": "#FF0000"}"""
    try:
        dialogue_response = generate_dialogue(session_id, prompt, session_histories)
        return jsonify({"dialogue_response": dialogue_response})
    except Exception as e:
        app.logger.error(f"Error in progress_story_positively: {str(e)}")
        return jsonify({"error": str(e)}), 500
    

      


# Forward the story negatively
@app.route('/negativeStory', methods=['GET'])
def progress_story_negatively():
    #data = request.get_json()
    #session_id = data['session_id']

    session_id = 1

    if session_id not in session_histories:
        return jsonify({"error": "Session ID not found. Please start a new session."}), 400
    prompt = """Forward the story negatively. Your response should be formatted as a JSON body as follows and only as follows:{"romeo_dialogue": "Please, just give me a chance. I’ve been thinking a lot, and I really want to explain myself.","juliet_dialogue": "Explain what, exactly? You hurt me, and it’s not something I can just forget.","color_hex_code": "#FF0000"}"""
    try:
        dialogue_response = generate_dialogue(session_id, prompt, session_histories)
        return jsonify({"dialogue_response": dialogue_response})
    except Exception as e:
        app.logger.error(f"Error in progress_story_negatively: {str(e)}")
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True)


@app.route('/endStoryTogether', methods=['POST'])
def end_story_with_together():
    data = request.get_json()
    session_id = data['session_id']

    if session_id not in session_histories:
        return jsonify({"error": "Session ID not found. Please start a new session."}), 400
    prompt = "Forward the story negatively."
    try:
        dialogue_response = generate_dialogue(session_id, prompt, session_histories)
        return jsonify({"dialogue_response": dialogue_response})
    except Exception as e:
        app.logger.error(f"Error in progress_story_negatively: {str(e)}")
        return jsonify({"error": str(e)}), 500

@app.route('/endStoryBreakup', methods=['POST'])
def end_story_with_breakup():
    prompt = 'End the story with the characters breaking up'

    # send prompt to agent

    return "blah"