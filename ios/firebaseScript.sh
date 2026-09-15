firebase_config="${SRCROOT}/Runner/GoogleService-Info.plist"

case "$CONFIGURATION" in
  Debug-dev|Profile-dev|Release-dev)
    cp "${SRCROOT}/Runner/dev/GoogleService-Info.plist" "$firebase_config"
    ;;
  Debug-prod|Profile-prod|Release-prod)
    rm -f "$firebase_config"
    echo "error: Missing production GoogleService-Info.plist configuration."
    exit 1
    ;;
esac
