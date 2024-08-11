#!/bin/bash

WATCH_DIR="/home/yomen/Documents/bluebird-teaching-frontend/src/components"
CSS_DIR="/home/yomen/Documents/bluebird-teaching-frontend/src/css"

COMPONENT_TEMPLATE='import React from "react";

const ComponentName = () => {
    return (
        <div>
            
        </div>
    );
};

export default ComponentName;'

inotifywait -m -e create --format "%f" "$WATCH_DIR" | while read FILENAME; do
    if [[ "$FILENAME" == *.js ]]; then
        COMPONENT_NAME="${FILENAME%.js}"
        CSS_FILE="$CSS_DIR/$COMPONENT_NAME.css"

        FINAL_TEMPLATE="import React from \"react\";\n\n"

        if [[ -f "$CSS_FILE" ]]; then
            RELATIVE_CSS_PATH="../css/$COMPONENT_NAME.css"
            FINAL_TEMPLATE="${FINAL_TEMPLATE}import '$RELATIVE_CSS_PATH';\n\n"
        fi

        FINAL_TEMPLATE="${FINAL_TEMPLATE}${COMPONENT_TEMPLATE//ComponentName/$COMPONENT_NAME}"

        echo -e "$FINAL_TEMPLATE" > "$WATCH_DIR/$FILENAME"
        echo "React component template added to $FILENAME"
    fi
done
