# Example profile to install basic system utilities

class profiles::base {
  include apt
  include ntp
  include logrotate

  package{'htop': }
}
