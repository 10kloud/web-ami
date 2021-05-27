sudo bash -c 'cat > /etc/environment <<EOF
PSQL_USERNAME="postgres"
PSQL_PASSWORD="postgres"
DOTNET_PORT=2021
DOTNET_CLI_TELEMETRY_OPTOUT=1
EOF'