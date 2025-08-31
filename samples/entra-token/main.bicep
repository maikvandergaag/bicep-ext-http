targetScope = 'local'
extension http

param tenantId string

@secure()
param clientId string

@secure()
param clientSecret string

param scope string = 'https://graph.microsoft.com/.default'

param grantType string = 'client_credentials'

#disable-next-line no-hardcoded-env-urls /* no environment function local scope */
var loginEndpoint = 'https://login.microsoftonline.com/'

var loginUrl = '${loginEndpoint}/${tenantId}/oauth2/token'

resource postHttp 'httpcall' = {
  url: loginUrl
  method: 'Post'
  headers:[
    {name: 'Content-Type', value: 'application/x-www-form-urlencoded' }
  ]
  body: 'client_id=${clientId}&scope=${scope}&client_secret=${clientSecret}&grant_type=${grantType}'
}

output accessToken string = json(postHttp.result).access_token
output statusCode int = postHttp.statusCode
