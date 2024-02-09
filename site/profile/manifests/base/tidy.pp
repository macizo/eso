#profile deleting files
#hiera parameter:
#profile::base::tidy
class profile::base::tidy{
  lookup('profile::base::tidy').each |$file| {
    files::tidy { $file['title']:
      matches   =>  $file['matches'],
    }
  }
}
