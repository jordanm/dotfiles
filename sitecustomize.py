import os, site

def has_module(path):
    for dirpath, dirname, filenames in os.walk(path):
        if '__init__.py' in filenames:
            return True

def add_projects(path):
    for dirname in os.listdir(path):
        fullpath = os.path.join(path, dirname)
        if has_module(fullpath):
            site.addsitedir(fullpath)

projectpath = os.environ.get('PROJECTPATH')
if projectpath:
    add_projects(projectpath)
