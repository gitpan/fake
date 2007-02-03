use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'fake',
    VERSION_FROM      => 'lib/fake.pm',
    PREREQ_PM         => {
        'version' => 0,
        'first'   => 0,
    }, 
    ($] >= 5.005 ?  
      (ABSTRACT_FROM  => 'lib/fake.pm', 
       AUTHOR         => 'Daniel Muey <http://drmuey.com/cpan_contact.pl') : ()),
);
