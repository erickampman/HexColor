#  HexColor

Turns out providing UI to enter a hex value for a color, as well as a ColorPicker, has sone oretty major gotchas.

- Ensuring the text input is only hex values
- Ensuring that the text input doesn't affect the color value unless there are 6 hex digits
- Ensuring that the conversion from Int to Float and back to Int doesn't change the Int
- Ensuring that entry via text sets the color properly, and changes the displayed color
- Ensuring that setting the color sets the hex text properly, and the color picker panel functions properly.
	- I found I have to close the color picker panel to get subsequent panels to work properly. A cludge.

This project demonstrates one way to get it all synchronized.

