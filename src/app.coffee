express = require 'express'
bodyParser = require 'body-parser'
exec = require('child_process').exec

{REGION, CLUSTER, SERVICE, CONTAINER} = process.env

if not REGION or not CLUSTER or not SERVICE or not CONTAINER
  console.log "One of the variables REGION, CLUSTER, SERVICE, CONTAINER, IMAGE is not defined"
  process.exit 1

ecsDeploy = (image, tag) ->
  process.env.IMAGE = image
  process.env.IMAGE_TAG = tag

  exec "ecs-deploy", (error, stdout, stderr) ->
    if error
      console.error(error)
      return

    console.log "#{stdout}"
    console.log "#{stderr}"


app = express()

app.use(bodyParser.json())

app.post '/docker/hub/webhook', (req, res) =>
  console.log """
              Received the following JSON:

              #{JSON.stringify(req.body, null, 2)}
              """
  ecsDeploy(req.body.repository.repo_name, req.body.push_data.tag)

  res.send JSON.stringify(req.body, null, 2)

app.listen process.env.PORT || 8080, =>
  console.log "Example app listening on port #{ process.env.PORT || 8080 }!"