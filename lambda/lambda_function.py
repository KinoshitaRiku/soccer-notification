import json
import boto3
from urllib import request
from datetime import datetime, timedelta

# env
prod = True
token = 'a65b95423fb44b0ba757f2098e1d2beb'
url = 'https://api.football-data.org/v4/teams/65/matches?status=SCHEDULED'
next_function = 'send-messeage-slack-api-kinoshita-mailCannel'

lambdaClient = boto3.client('lambda')

def lambda_handler(event, context):
  football_data = access_api_football_data()
  date_now = datetime.now()
  # date_now = datetime(2023, 1, 5, 18, 00, 00, 0) # debag用
  output_text = create_output_text(football_data, date_now)
  if prod == True:
    action_other_lambda(output_text)
  else:
    print(output_text)

def access_api_football_data():
  headers = {'Accept': 'application/json', 'X-Auth-Token': token}
  request_get = request.Request(url, headers=headers)
  with request.urlopen(request_get) as res:
    body = json.load(res)
  return body

def create_output_text(fotball_data, date_now):
  range_date = date_now + timedelta(hours=12)
  matches = fotball_data['matches']
  # print(get_japan_match_date(matches[0]))# debag用
  notification_content = ""

  for match in matches:
    japan_match_date = get_japan_match_date(match)
    if date_now < japan_match_date and japan_match_date < range_date:
      content_date = "date: " + japan_match_date.strftime('%Y-%m-%d %H:%M:%S')
      content_matchday = "matchweek: " + str(match['matchday']) # PLの公式はmatchdayではなく、matchweekと表現している。
      content_teams = match['homeTeam']['name'] + " vs " + match['awayTeam']['name']
      notification_content = content_date + '\n' + content_matchday + '\n' + content_teams
      break
    else:
      notification_content = "なし"

  return notification_content

def get_japan_match_date(match):
  utc_date = match['utcDate'] # 2022-08-27T14:00:00Z
  england_match_date = datetime.strptime(utc_date, '%Y-%m-%dT%H:%M:%SZ')
  japan_match_date = england_match_date + timedelta(hours=9)
  return japan_match_date

def action_other_lambda(data):
  payload = {
    "params":data
  }
  
  lambdaClient.invoke(
    FunctionName=next_function,
    InvocationType='RequestResponse',
    Payload=json.dumps(payload)
  )

if prod == False:
  lambda_handler("", "")