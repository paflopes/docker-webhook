express = require 'express'
bodyParser = require 'body-parser'

app = express()

app.use(bodyParser.json())

app.post '/docker/hub/webhook', (req, res) =>
  res.send JSON.stringify(req.body, null, 2)

app.listen 8080, =>
  console.log 'Example app listening on port 8080!'