import os
import pathlib
import yaml

ROOT = "settings"


class ProjectSettingsBuilder:
    def __init__(self):
        self.name = "project_settings.yaml"
        self.file = dict()
        self.stack = list()

    def add_row(self, ancestor, setting, value):
        if not self.stack:
            self.stack = [self.file]
        if not ancestor:
            self.file[setting] = value
            return
        for key, item in self.stack[-1].items():
            if isinstance(item, dict):
                if key == ancestor:
                    item[setting] = value
                    self.stack = [self.file]
                    return
                self.stack.append(item)
                self.add_row(ancestor, setting, value)
        if self.stack:
            self.stack.pop(-1)


class SettingsManager:
    def __init__(self):
        self.project_settings = ProjectSettingsBuilder()
        self.file = None
        self.stack = list()
        self.setting_selection = [ROOT]

    def build_project_settings(self):
        if self.project_settings.name in os.listdir(pathlib.Path(__file__).parent):
            self.file = yaml.safe_load(open(os.path.join(os.path.dirname(__file__), self.project_settings.name),
                                            'r', encoding="utf-8"))
            self.update_file()
        else:
            self.file = self.project_settings.file
        yaml.dump(self.file, open(os.path.join(os.path.dirname(__file__), self.project_settings.name),
                                  'w', encoding="utf-8"))


    def update_file(self, history=tuple()):
        if not self.stack:
            self.stack = [self.project_settings.file]
        self_file_section = None
        for key, value in self.stack[-1].items():
            if key not in (self_file_section := self.reach_file_section(history)):
                self_file_section[key] = value
            if isinstance(value, dict):
                self.stack.append(value)
                self.update_file(history + (key,))
        if self_file_section:
            for key in list(self_file_section.keys()):
                if key not in self.stack[-1]:
                    del self_file_section[key]
        if self.stack:
            self.stack.pop(-1)

    def reach_file_section(self, history=tuple()):
        dictionary = self.file
        for elem in history:
            dictionary = dictionary[elem]
        return dictionary

    def __getattr__(self, item):
        self.setting_selection.append(item)
        return self

    def get(self):
        value = self.file
        for elem in self.setting_selection:
            value = value[elem]
        self.setting_selection = [ROOT]
        return value


settings_manager = SettingsManager()
append_setting = settings_manager.project_settings.add_row

# Ancestor must be unique!
append_setting(None, ROOT, dict())
append_setting(ROOT, "database", dict())
append_setting("database", "host", "mongodb://localhost")
append_setting("database", "docker_host", "mongo")
append_setting("database", "port", 27017)
append_setting("database", "docker_port", 27017)
append_setting(ROOT, "api", dict())
append_setting("api", "host", "localhost")
append_setting("api", "port", 8000)
append_setting(ROOT, "docker", dict())
append_setting("docker", "base_container", "python:latest")

settings_manager.build_project_settings()

