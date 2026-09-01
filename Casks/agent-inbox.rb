cask "agent-inbox" do
  version "0.1.24"
  sha256 "5de733abef49760bd150d7e672b3914d2c2cac3384b56bae5adac1e9b48c9b01"

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
