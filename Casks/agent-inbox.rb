cask "agent-inbox" do
  version "0.1.34"
  sha256 "bf2437a4a62d8138d4682f4b62a0a181be15997f56158d66ac9c97e69d5d496c"

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
