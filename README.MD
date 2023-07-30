# Sprite Reassembler
(for lack of a better name)

Recommended GM version: 2023.6

I initially wrote this utility for automating means to extract assets from MAME Tilemap Viewer screenshots and be able to piece the fragments together in-app.

It can also save assembled pieces with reasonable precision so you don't need to screenshot the app, and also offers saving of processed fragment strips.

As of late July 2023, it can also save entire projects as a ZIP containing a JSON and every imported fragment sprite, so you can pick up where you left off if you need to resume work later.

### Default Controls

**Listings may not always be par with source, check obj_ctrl_main**

- **ESC:** Quit
- **F1:** Show This Window
- **F2:** Restart
- **F4:** Fullscreen toggle
- **F5:** Load Project File
- **F6:** Save Project File
- **CTRL + ARROWS:** Set width/height for fragment creation/save area
- **SPACE:** Start Saving mode, set width/height then tap again to save to file
- **WSAD:** View Move
- **1:** Open Sprite Splitter window
- **8:** Toggle Grid with current sprite spacing
- **9/0:** Zoom In/Out (WARNING: Zoom Out before using Save Mode for reliable results)
- **Left Mouse (off fragment):** Create new fragment / De-select existing fragment
- **Left Mouse (on fragment):** Select fragment
- **Shift + Left Mouse:** Select Multiple fragments

### While a fragment is selected:

- **Z/X:** Change starting subimage index
- **C:** Reverse index increment
- **D:** Set reverse index starting value (experimental)
- **Right Mouse (anywhere):** De-Select All
- **Right Mouse + Shift (on fragment):** Deselect fragment


### Known Limitations

Even with restrictions disabled, GameMaker does not currently allow writing to program_directory.
The internal UI is entirely handmade and probably not terribly optimal for performance, sorry.