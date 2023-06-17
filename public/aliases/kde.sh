
function splitkonsole () {
  # Split konsole session
  # Uses spiral layout
  # Warning: This uses the most recent Konsole window opened!
  # Usage:
  # split-konsole "ssh host1" "ssh host2"

    # The builtin variables don't seem to be accurate and don't give the MainWindow
    export CURRENT_KONSOLE_SESSION=$(qdbus $KONSOLE_DBUS_SERVICE | grep -o '/Sessions/.*' | sort | tail -n1 | egrep -o "[0-9]+")
    export CURRENT_KONSOLE_WINDOW=$(qdbus $KONSOLE_DBUS_SERVICE | grep -o '/konsole/MainWindow_[0-9]\+$' | sort | tail -n1)
    # Create counter
    export i=1
    for command in ${@:1}; do
        CURRENT_KONSOLE_SESSION=$((CURRENT_KONSOLE_SESSION+1))
        if [[ $( expr $i % 2 ) -eq 0 ]]; then
            splitmethod=split-view-top-bottom
        else
            splitmethod=split-view-left-right
        fi
        if qdbus org.kde.konsole $CURRENT_KONSOLE_WINDOW org.kde.KMainWindow.activateAction $splitmethod; then echo "Created new session ${i} with command ${command}"; fi
          qdbus org.kde.konsole /Sessions/${CURRENT_KONSOLE_SESSION} org.kde.konsole.Session.runCommand "${command}" >/dev/null
        i=$((i+1))
  done
}
