# Example profile to install some basic emacs tools

class profiles::emacs {
  # Hmmm.... no emacs package is avalable yet...
  # I should fix it, but while I do that...
  package emacs
  package emacs-el
  package emacs-goodies-el
  package puppet-el
}
