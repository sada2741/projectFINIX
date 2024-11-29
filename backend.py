import plaid
from plaid.api import plaid_api

# Configure Plaid API
configuration = plaid.Configuration(
    host=plaid.Environment.Sandbox,  # Use Sandbox, Development, or Production
    api_key={
        'clientId': '66e8187d6b77c900199ca864',
        'secret': '4836c715ac62ec5fa18ab9b119004f',
    }
)
client = plaid_api.PlaidApi(plaid.ApiClient(configuration))

# Function to create a link token
def create_link_token():
    try:
        request = {
            "user": {"client_user_id": "66e8187d6b77c900199ca864"},  # Replace with your unique user ID
            "client_name": "Your App Name",
            "products": ["auth", "transactions"],  # List of Plaid products
            "country_codes": ["US"],
            "language": "en"
        }
        response = client.link_token_create(request)
        return response['link_token']  # Returns the link token
    except plaid.ApiException as e:
        print(f"Error: {e}")
        return None

# Generate and print the link token
if __name__ == "__main__":
    token = create_link_token()
    if token:
        print(f"Link Token: {token}")
