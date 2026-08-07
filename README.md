# Godot Project Setup

This repository contains a game developed using the **Godot Engine**. Follow the instructions below to download, open, and run the project locally.

## Repository

**GitHub Link:**
[Repo Link](https://github.com/godondi/assembly-adventures.git)

## Requirements

Before running the project, make sure you have:

* **Godot Engine** installed
* **Git** installed if you plan to clone the repository
* A computer that meets Godot's system requirements

This project is intended to run using **Godot 4.x**.

## 1. Clone the Repository

Open a terminal and run:

```bash
git clone [INSERT GITHUB REPOSITORY LINK HERE]
```

Then navigate into the project directory:

```bash
cd [REPOSITORY-NAME]
```

Alternatively, you can download the repository as a ZIP file from GitHub and extract it to your computer.

## 2. Open the Project in Godot

1. Open **Godot Engine**.
2. From the **Project Manager**, click **Import**.
3. Navigate to the cloned or downloaded repository.
4. Select the `project.godot` file.
5. Click **Import & Edit**.

Godot should automatically recognize the project and load its files.

## 3. Run the Project

Once the project is open:

1. Allow Godot to finish importing any assets.
2. Click the **Run Project** button in the upper-right corner of the editor.

You can also press:

```text
F6 – Run the current scene
F5 – Run the entire project
```

If Godot asks you to select a main scene, choose the project's starting scene.

## Troubleshooting


### Assets are missing

Wait for Godot to finish importing all project assets. If necessary, close and reopen the project.

### Project opens with errors

Make sure you are using the correct version of Godot. Projects created with Godot 4 may not work correctly in Godot 3.

### Repository was cloned but the game will not run

Make sure all repository files were downloaded successfully:

```bash
git pull
```

Then reopen the project in Godot.

## Updating Your Local Repository

If you have already cloned the project and want to retrieve the latest changes, navigate to the repository and run:

```bash
git pull
```

## Development

When making changes, create a new branch when appropriate:

```bash
git checkout -b your-branch-name
```

After making changes:

```bash
git add .
git commit -m "Describe your changes"
git push
```

## Notes

Do not commit Godot-generated cache or temporary files unless they are specifically required by the project. The repository's `.gitignore` file should handle these files automatically.
