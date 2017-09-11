// Your init script
//
// Atom will evaluate this file each time a new window is opened. It is run
// after packages are loaded/activated and after the previous editor state
// has been restored.
//

// Toggle between light and dark theme.
atom.commands.add('atom-workspace', 'dot-atom:toggle-theme', () => {
    var activeThemes = atom.themes.getActiveThemeNames();

    if (activeThemes[0].indexOf("light") > 0) {
        atom.config.set("core.themes", ["one-dark-ui", "one-dark-syntax"]);
    } else {
        atom.config.set("core.themes", ["one-light-ui", "one-light-syntax"]);
    }
});

if (document.readyState && atom.workspace.getRightDock().state.visible) {
    atom.commands.dispatch(atom.views.getView(atom.workspace.getRightDock()), 'window:toggle-right-dock');
}
