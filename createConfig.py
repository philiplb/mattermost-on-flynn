import os
import json

configJSON=open("defaultConfig.json").read()
config = json.loads(configJSON)

for envVar in os.environ:
	if envVar.startswith("MM_"):
		key = envVar[3:]
		jsonPath = key.split("_")
		lastKey = jsonPath.pop()
		targetElement = config
		for pathElement in jsonPath:
			targetElement = targetElement[pathElement]
		jsonValue=json.loads("{\"value\":"+os.environ[envVar]+"}")
		targetElement[lastKey] = jsonValue["value"]
		print("Set " + ".".join(jsonPath) + "." + lastKey + " to " + json.dumps(jsonValue["value"]))

with open('config.json', 'w') as fp:
    json.dump(config, fp, indent=4)
