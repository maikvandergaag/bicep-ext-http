targetScope = 'local'
extension http

var callBody = loadTextContent('sample/body.json')

resource getHttp 'httpcall' = {
  url: 'https://bicep-local.free.beeceptor.com'
  method: 'Get'
}

resource postHttp 'httpcall' = {
  url: 'https://bicep-local.free.beeceptor.com'
  method: 'Post'
  headers:[
    {name: 'Content-Type', value: 'application/json' }
  ]
  body: callBody
}

resource deleteHttp 'httpcall' = {
  url: 'https://bicep-local.free.beeceptor.com/1'
  method: 'Delete'
}

output getResponse object = json(getHttp.result)
output getStatusCode int = getHttp.statusCode
output postResponse object = json(postHttp.result)
output postStatusCode int = postHttp.statusCode
output deleteStatusCode int = deleteHttp.statusCode
