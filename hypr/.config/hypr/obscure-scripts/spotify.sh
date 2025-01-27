ACCENT=$(jq -r '.colors.color6' ~/.cache/wal/colors.json | sed 's/#//')
ACCENT_ACTIVE=$(jq -r '.colors.color1' ~/.cache/wal/colors.json | sed 's/#//')
ACCENT_INACTIVE=$(jq -r '.colors.color9' ~/.cache/wal/colors.json | sed 's/#//')
BANNER=$(jq -r '.colors.color4' ~/.cache/wal/colors.json | sed 's/#//')
BORDER_ACTIVE=$(jq -r '.colors.color4' ~/.cache/wal/colors.json | sed 's/#//')
BORDER_INACTIVE=$(jq -r '.colors.color12' ~/.cache/wal/colors.json | sed 's/#//')
HEADER=$(jq -r '.colors.color6' ~/.cache/wal/colors.json | sed 's/#//')
HIGHLIGHT=$(jq -r '.colors.color7' ~/.cache/wal/colors.json | sed 's/#//')
MAIN=$(jq -r '.colors.color0' ~/.cache/wal/colors.json | sed 's/#//')
NOTIFICATION=$(jq -r '.colors.color10' ~/.cache/wal/colors.json | sed 's/#//')
NOTIFICATION_ERROR=$(jq -r '.colors.color12' ~/.cache/wal/colors.json | sed 's/#//')
SUBTEXT=$(jq -r '.colors.color12' ~/.cache/wal/colors.json | sed 's/#//')
TEXT=$(jq -r '.colors.color15' ~/.cache/wal/colors.json | sed 's/#//')

# Apply these colors to Spicetify theme's color.ini file
sed -i "s/accent             = .*/accent             = $ACCENT/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/accent-active      = .*/accent-active      = $ACCENT_ACTIVE/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/accent-inactive    = .*/accent-inactive    = $ACCENT_INACTIVE/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/banner             = .*/banner             = $BANNER/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/border-active      = .*/border-active      = $BORDER_ACTIVE/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/border-inactive    = .*/border-inactive    = $BORDER_INACTIVE/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/header             = .*/header             = $HEADER/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/highlight          = .*/highlight          = $HIGHLIGHT/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/main               = .*/main               = $MAIN/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/notification       = .*/notification       = $NOTIFICATION/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/notification-error = .*/notification-error = $NOTIFICATION_ERROR/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/subtext            = .*/subtext            = $SUBTEXT/" ~/.config/spicetify/Themes/themefr/color.ini
sed -i "s/text               = .*/text               = $TEXT/" ~/.config/spicetify/Themes/themefr/color.ini

spicetify apply


