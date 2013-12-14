class base::basedir {

    file {  '/data':
                ensure =>   "directory",
                owner  =>   "root",
                group  =>   "root",
                mode   =>   "0755",
    }

}
