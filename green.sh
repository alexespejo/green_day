green_emojis=(🍏 🍐 🥒 🥬 🥦 🌿 🍀 🌱 🌲 🌳 🐢 🦖 🦎 ✅ 💚)
commit_changes() {
    random_emoji=${green_emojis[RANDOM % ${#green_emojis[@]}]}

    echo "### $(date): Daily $random_emoji!" >> "README.md"

    if [ $? -eq 0 ]; then
        echo "Content written to README.md successfully."
    else
        echo "Error writing to README.md"
        return 1
    fi

    if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
        git add . 
        git qush "Daily $random_emoji"

        if [ $? -eq 0 ]; then
            echo "Changes committed successfully."
        else
            echo "Error committing changes."
            return 1
        fi
    else
        echo "This directory is not a Git repository. Cannot commit changes."
        return 1
    fi
}

flag=1
echo "Green Day! ❇️" 
while true; do
	if [[ $(date +%H) -ge 00 ]]; then
		if [ $flag -eq 1 ]; then
				commit_changes
				flag=0
		fi 
	fi

	if [[ $(date +%H) -eq 00 ]]; then
		flag=1
	fi 
done
