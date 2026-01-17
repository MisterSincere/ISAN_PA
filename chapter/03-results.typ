= Results

== Emergency select page
This page is only visible if there are more than one registered ISANs received from the responding system. If there was only one emergency received it will automatically forward to the emergency view page of that emergency. Otherwise it provides rather big buttons showing the raw ISAN.
#figure(
  image("../assets/emergency_select.png"),
  supplement: [Image],
  caption: [Screenshot showing the page where all available emergencies will be listed and can be selected.]
)

== Emergency view page
This page is the one that is designed as the main page where the user will be.
On the top is a menu with an orange background, which on the left side shows a reduced version of the currently selected ISAN only showing date, time and location and on the right shows weather data for according emergency location.
The current (reduced) ISAN can be clicked to show a dropdown with all known current emergencies.

While the top bar provides more meta information, the left side bar provides navigation within information regarding the selected emergency.
Therefore it shows all available modules, meaning modules for which data has been received and modules for received data which have a module front end definition.
When entering the page, the list only shows big icons of each module, but it can be expanded to also show the module name.
To open a module the according icon or module name can be clicked. 
Opening a module will show its representation in the main area at the center of the screen, but the top and left navigation bars will stay the same.
Moreover the current opened module (or dashboard) will have a different background indicating the current location.
No module will be opened automatically. Instead an empty dashboard (if the page is visited the first time) is shown.

The dashboard has its own top bar with the headline "Dashboard" and a big button on the right, which opens a dropdown to add or remove (indicated by the checkbox next to it) a module to the dashboard as a tile.
Furthermore the dashboard shows green zones. Those green zones are dropzones. While not automatically when added to the dashboard, a module tile will snap to the according zone when dropped onto.
The initial dropzones only allow to split for half of the screen and not a quarter.
For that a tile can be dropped onto another tile that is already pinned to one of the dropzones: if done in the middle of that tile it will be replaced, but if done left or right for vertical splitting or top or bottom for horizontal splitting it will split the previous tile in half and place the dragged one accordingly to the location it was dragged to.

Each module tile has two buttons: the maximize button on the top left and the close button on the top right.
The close button removes that tile from the dashboard and the maximize button opens the according module page.
If the page is closed the current tile arrangement will be cached so that once it is reopened the previous arrangement is loaded and displayed.
In-between those buttons it shows the name of the module this tile belongs to.

#figure(
  image("../assets/emergency_view.png"),
  supplement: [Image],
  caption: [Screenshot of the core page of this project, where all the data for the selected emergency can be viewed.],
)
