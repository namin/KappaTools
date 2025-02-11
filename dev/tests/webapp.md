# Tests webapp

For now, tests to be done manually in the app

Should be done in each considered brower and in the electron app, and importantly at least on windows and mac


## Test procedure

First level of dashes: what to do

Second level: what to check additionnally

#### Open the app
- open the app with argument `?level=debug`, open the browser console. If on electron, this is done by modifying `main.js`. use it in the following to check if operations trigger errors that would not be visible in the interface

#### Load and editor
- load file https://tools.kappalanguage.org/try/?model=https%3A//raw.githubusercontent.com/Kappa-Dev/KappaTools/master/examples/abc.ka
- make an error in the file, for instance delete last character in line 21 `%obs: 'Cuu' |C(x1{u},x2{u})|`
  check that the error is displayed in the gutter on the left, and in the code underlined in red, and at the bottom right : `1/1[abc.ka] Illegal definition of variable 'Cuu' `
- undo the error e.g. ctrl+z
- add at the end of the file: `%agent: D(a{u p})`
  - check that warning dead agent is shown in the gutter and at the bottom right
- add `'d' D(a{p}) -> D(a{u}) @ 1`
  - check that the dead rule warning show up in the same way
- delete those lines
- click twice on toggle to check the opening/closure
- Resize the window and see that no error is shown in the console


#### Right subpanel
- Contact map is present, see that it changes when clicked on - interactive mode - show all states
- zoom with mouse wheel, reset with button `Reset Zoom`
- export to svg and check the picture
- Go to influences: is it populated?
- Change rendering to graph, change accuracy to high, see that it changes; play with size radius controls
- Change back to Tabular, click Track cursor. click on different rules in the editor to see that it changes in the subpanel; click on previous/next similarly
- export to json and check that info is present in the file
- Go to constraints subpanel, see that the two views domain are populated
- Go to polymers, see that it shows `The size of biomolecular compounds is uniformly bounded.`

#### Simulation, plot
- Add `[T] > 10` in `Pause if`, click on start, see that it showed "running" with events and time, and now Paused
- Click on continue, see the simulation doesn't run, delete contents of `Pause if`
- Click on continue, then on pause. See that it showed "running" with events and time, and now Paused
- change to tab log, see that it shows lines with + Building initial simulation conditions...   and random seed used
- Change to plot, click on the different plot axes options and see the changes
- Continue/pause the simulation and see the plot changing, move the plot position with the slider
- Export the plot to svg and open it
- Same with csv

#### DIN, snapshots, outputs
- Change to DIN tab, check that a table is populated and that we can switch to the second table
- Export to json and check the file 
- Change to Snapshot tab, enter $SNAPSHOT in the Simulation perturbation and click intervention, see that the snapshot shows up
- Click on kappa and change display to graph, play with the graph settings
- Change back to kappa, continue/pause the simulation, make a new snapshot, and test to switch between snapshot
- Go to outputs, run `$PRINT "time: ".[T] > "time.txt"` and  `$PRINT 'AB' > "ab.txt"` see that it shows up, run a bit the simulation, run one of them again, check that we can see all values
- Go back to log tab and see the previous interventions show up
- Click on `All outputs` in the simutation, check that the following files are present and not empty: log.txt, inputs.ka, flux.json, flux.html, data.csv, snap and snap_xxxxxx

#### Files
- Hit clear to clear up the simulation
- File>export and download the file as abc.ka
- Close the file, then file> open, open back the file
- File> new enter a name as `test.ka`, fill with the contents: https://www.di.ens.fr/~feret/teaching/2023-2024/MPRI.2.19/activities/causality/causality_slide_10.ka
  - See the update of the contact map with both
- Start simulation, See if both file show up on the plot tab
- Select file abc.ka, close it, see update in contact map

#### Stories
- Click get trace at the bottom and check file, json with empty trace
- If not done in previous section, Copy/paste in the editor https://www.di.ens.fr/~feret/teaching/2023-2024/MPRI.2.19/activities/causality/causality_slide_10.ka
- Go to preferences, enable store trace, click Set
- clear/start the simulation, it stops because of last `%obs`
- Click get trace at the bottom and check the file contains a non empty trace section (TODO: reference?)
- Go to the stories tab, click launch
- See that the computation log show up, that a story graph appears on the right
- Click on story_info log, see that it shows up
- Change the story, see the story_info log and graph changes
- Test causal and strongly compressed stories the same way

#### New project
- Click new project, enter a name
- Load a file e.g. abc.ka, run the simulation, check e.g. the plot
- go back to project `default`, check editor, log and plot tabs didn't change

#### Other subpanel analysis tools
- Load https://raw.githubusercontent.com/Kappa-Dev/KappaTools/master/examples/poly.ka and see the polymers subpanel show info about chain possibilities
- Load https://www.di.ens.fr/~feret/teaching/2023-2024/MPRI.2.19/activities/local_views/local_views_slide_69.ka , check in the constraints panel that info is shown for all except counters, that the last rule is flagged as a dead rule
- Load https://raw.githubusercontent.com/Kappa-Dev/KappaTools/master/tests/integration/compiler/counters_2_levels/counter_2.ka , check that counters info show in constraints panel
- Load https://raw.githubusercontent.com/Kappa-Dev/KappaTools/master/examples/large/minikai/minikai_counters.ka change accuracy contact map: d shows up or not
