from flask import Flask, jsonify
import plaid
from plaid.api import plaid_api

app = Flask(__name__)

# Configure Plaid API
configuration = plaid.Configuration(
    host=plaid.Environment.Sandbox,
    api_key={
        'clientId': '66e8187d6b77c900199ca864',
        'secret': '4836c715ac62ec5fa18ab9b119004f',
    }
)
client = plaid_api.PlaidApi(plaid.ApiClient(configuration))

@app.route('/create_link_token', methods=['GET'])
def create_link_token():
    try:
        request = {
            "user": {"client_user_id": "66e8187d6b77c900199ca864"},
            "client_name": "Your App Name",
            "products": ["auth", "transactions"],
            "country_codes": ["US"],
            "language": "en"
        }
        response = client.link_token_create(request)
        return jsonify({"link_token": response['link_token']})
    except plaid.ApiException as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
