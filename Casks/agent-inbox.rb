cask "agent-inbox" do
  version "0.1.30"
  sha256 "d8136b1292ed7dc6c37cd7385d4adb4ec27ff2c2d69be2be27401016b77908f9"

  url "https://github.com/Ideaplaces/agent-inbox/releases/download/v#{version}/AgentInbox-#{version}.dmg",
      verified: "github.com/Ideaplaces/agent-inbox/"
  name "Agent Inbox"
  desc "Native notifications for every Claude Code session that finishes or needs you"
  homepage "https://github.com/Ideaplaces/agent-inbox"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Agent Inbox.app"

  # Open it once the files are in place.
  #
  # A cask copies a bundle and stops. For a menubar app that is the whole
  # install failing quietly: nothing is running, nothing is in Login Items,
  # no hooks are written, and the first sign of it is a day with no
  # notifications. The app's own first launch does the rest, so this one line
  # is the difference between "installed" and "working". On an upgrade the
  # `uninstall quit:` above has just closed it, so this puts it back.
  postflight do
    system_command "/usr/bin/open", args: ["-a", "#{appdir}/Agent Inbox.app"]
  end

  uninstall quit: "com.ideaplaces.agent-inbox"

  # The hooks in ~/.claude/settings.json and the unpacked notify.sh are removed
  # from the app's own Settings, not here: they keep working without the app,
  # which is the point of putting them outside the bundle.
  zap trash: [
    "~/Library/Preferences/com.ideaplaces.agent-inbox.plist",
    "~/Library/Caches/com.ideaplaces.agent-inbox",
  ]
end
