#!/bin/bash
# Commander-ShepardN7
# Gmail account credentials
username="username@gmail.com"
password="16 digit password (no blanks)"
offset="    "  # Adjust the number of spaces for desired offset

# Fetch Gmail feed and parse titles of the 6 most recent emails, you can edit out "important" to get all mails
curl -s -u "$username:$password" https://mail.google.com/mail/feed/atom/important | \
grep -o "<title>[^<]*" | \
grep -v "Gmail - Label &#39;important&#39; for $username" | \
sed 's/<[^0-9]*>//g' | \
head -n 6 | \
fold -s -w 25 | \
sed "s/^/${offset}/"  # Add spaces at the start of each line

