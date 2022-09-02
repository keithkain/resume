.PHONY: build

build:
	sam build

deploy-infra:
	sam build && aws-vault exec crc-sam-user --no-session -- sam deploy

deploy-site:
	aws-vault exec crc-sam-user --no-session -- aws s3 sync ./resume-site s3://keithkain-cv

invoke-put:
	sam build && aws-vault exec crc-sam-user --no-session -- sam local invoke PutDBFunction

integration-test:
	apiUrl=https://2kfwqnp01i.execute-api.us-east-1.amazonaws.com/Prod 
	FIRST=$(curl -s "$apiUrl/get" | jq tonumber); \
    curl -s "$apiUrl/put"; \
	SECOND=$(curl -s "$apiUrl/get" | jq tonumber); \
    echo "Comparing if first count ($FIRST) is less than (<) second count ($SECOND)"; \
	if [[ $FIRST -le $SECOND ]]; then echo "PASS"; else echo "FAIL";  fi