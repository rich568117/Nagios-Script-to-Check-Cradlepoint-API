CP_API_ID="YOUR CP API ID"
CP_API_KEY="YOUR CP API KEY"
ECM_API_ID="YOUR ECM API ID"
ECM_API_KEY="YOUR ECM API KEY"
URL="https://www.cradlepointecm.com/api/v2/routers/?name=Conroe-ROIP"
curl -sS -H "X-ECM-API-ID: $ECM_API_ID" -H "X-ECM-API-KEY: $ECM_API_KEY" -H "X-CP-API-ID: $CP_API_ID" -H "X-CP-API-KEY: $CP_API_KEY" -H "Content-Type: application/json" -L --request GET $URL | jq -r .data > output.txt
result=$(jq '.[] | .state' output.txt)

check_cradlepoint(){

case $result in
 ['"online"']*)
 echo "OK - $1 is online."
 exit 0
 ;;
 *)
 echo "CRITICAL - $1 is offline."
 exit 3
 ;;
 esac
}

check_cradlepoint $1
