.PHONY: build

build:
	sam build

deploy-infra:
	sam build && aws-vault exec crc-sam-user --no-session -- sam deploy

deploy-site:
	aws-vault exec crc-sam-user --no-session -- aws s3 sync ./resume-site s3://keithkain-cv

invoke-put:
	sam build && aws-vault exec crc-sam-user --no-session -- sam local invoke PutDBFunction