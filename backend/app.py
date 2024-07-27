from flask import Flask, request, jsonify

app = Flask(__name__)

base_prompt = """
    You are a storyteller telling a story about two lovers in the form of a back-and-forth dialogue where a character named Romeo is 
    is trying to convince another character named Juliet to get back together. By the end of the dialogue, the characters should come to a decision 
    that they [do / do not] get back together. Throughout the dialogue, LoverB wavers between getting back together and breaking up.

    Throughout this conversation, you will be prompted to forward the story either positively or negatively. With each prompt, forward the story as instructed in the form of 
    two lines of dialogue between Romeo and Juliet. And then analyze the tone of the "juliet_dialogue" and provide 
    a color hex code that represents the tone of the dialogue. Try to use a wide spectrum of colors and to not repeat colors.

    Your response should be formatted as a JSON body as follows:
    {
        "romeo_dialogue": "Please, just give me a chance. I’ve been thinking a lot, and I really want to explain myself.",
        "juliet_dialogue": "Explain what, exactly? You hurt me, and it’s not something I can just forget.",
        "color_hex_code": "#FF0000"
    }
    """


@app.route('/')
def start_game():
    # initialize the agent chat session + provide base prompt here

    return "hello world"

@app.route('/positiveStory', methods=['POST'])
def progress_story_positively():
    prompt = 'Progress the story positively'

    # send prompt to agent


    agent_output = ''

    response = agent_output
    return response

@app.route('/negativeStory', methods=['POST'])
def progress_story_negatively():
    prompt = 'Progress the story negatively'

    # send prompt to agent


    agent_output = ''

    response = agent_output
    return response


@app.route('/endStoryTogether', methods=['POST'])
def end_story_with_together():
    prompt = 'End the story with the characters getting back together'

    # send prompt to agent

    return "blah"

@app.route('/endStoryBreakup', methods=['POST'])
def end_story_with_breakup():
    prompt = 'End the story with the characters breaking up'

    # send prompt to agent

    return "blah"


if __name__ == '__main__':
    app.run(debug=True)