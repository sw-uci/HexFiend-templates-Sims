# Binary Templates
Sims.tcl is a [Hex Fiend](https://github.com/ridiculousfish/HexFiend) Binary Template that helps you analyze EA's DBPF 2.1 binary file format. Information about Hex Fiend Binary Templates can be found [here](https://github.com/ridiculousfish/HexFiend/tree/master/templates).

## Installation
1. Install Hex Fiend from [here](https://github.com/ridiculousfish/HexFiend/releases).
1. Open Hex Fiend at least once.
1. Install ```Sims.tcl``` to ```~/Library/Application Support/com.ridiculousfish.Hex Fiend/Templates```. Make the Templates folder if it does not exist.

## Usage
1. In Hex Fiend's menubar, select ```Views -> Binary Templates```. A sidebar should show up with title "Templates".
1. Once you've installed ```Sims.tcl```, click the Templates dropdown in the sidebar, and select Refresh. ```Sims``` should now show in the dropdown.
1. Open a DBPF file.
1. Select ```Sims``` in the Templates dropdown. Analysis of the file will show in the sidebar.

## Notes
### Caveats
This is not a 100% complete interpretation of the binary format. 
- Not all IndexTypes are implemented.
- Some header vars in the IndexEntry may not be accurate. These are marked with a question mark (?).
- RawRecords has an incomplete analysis regarding encryption and data regions.

### See Also
[Maxis Documentation for The Sims 4](https://forums.thesims.com/en_US/discussion/779844)

[TS4_Custom_Content_Guide.zip](http://cdn-assets-ts4.pulse.ea.com/Guide/TS4_Custom_Content_Guide.zip) as linked in the above forum thread.
