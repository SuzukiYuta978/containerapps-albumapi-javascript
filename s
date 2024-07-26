[33mcommit 92695c55a94ee3109070efd320657dc9fe909d3f[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmain[m[33m)[m
Author: SuzukiYuta978 <suzuki.yuta.978@tis.co.jp>
Date:   Fri Jul 19 11:29:04 2024 +0900

    first commit

[1mdiff --git a/.dockerignore b/.dockerignore[m
[1mnew file mode 100644[m
[1mindex 0000000..809ba83[m
[1m--- /dev/null[m
[1m+++ b/.dockerignore[m
[36m@@ -0,0 +1,24 @@[m
[32m+[m[32m**/.classpath[m
[32m+[m[32m**/.dockerignore[m
[32m+[m[32m**/.env[m
[32m+[m[32m**/.git[m
[32m+[m[32m**/.gitignore[m
[32m+[m[32m**/.project[m
[32m+[m[32m**/.settings[m
[32m+[m[32m**/.toolstarget[m
[32m+[m[32m**/.vs[m
[32m+[m[32m**/.vscode[m
[32m+[m[32m**/*.*proj.user[m
[32m+[m[32m**/*.dbmdl[m
[32m+[m[32m**/*.jfm[m
[32m+[m[32m**/charts[m
[32m+[m[32m**/docker-compose*[m
[32m+[m[32m**/compose*[m
[32m+[m[32m**/Dockerfile*[m
[32m+[m[32m**/node_modules[m
[32m+[m[32m**/npm-debug.log[m
[32m+[m[32m**/obj[m
[32m+[m[32m**/secrets.dev.yaml[m
[32m+[m[32m**/values.dev.yaml[m
[32m+[m[32mLICENSE[m
[32m+[m[32mREADME.md[m
[1mdiff --git a/.vscode/launch.json b/.vscode/launch.json[m
[1mindex ea6a11a..f19b60a 100644[m
[1m--- a/.vscode/launch.json[m
[1m+++ b/.vscode/launch.json[m
[36m@@ -22,6 +22,13 @@[m
       "serverReadyAction": {[m
         "action": "openExternally"[m
       }[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "name": "Docker Node.js Launch",[m
[32m+[m[32m      "type": "docker",[m
[32m+[m[32m      "request": "launch",[m
[32m+[m[32m      "preLaunchTask": "docker-run: debug",[m
[32m+[m[32m      "platform": "node"[m
     }[m
   ][m
 }[m
[1mdiff --git a/.vscode/tasks.json b/.vscode/tasks.json[m
[1mindex 435b08c..371e40c 100644[m
[1m--- a/.vscode/tasks.json[m
[1m+++ b/.vscode/tasks.json[m
[36m@@ -12,6 +12,40 @@[m
       "problemMatcher": [],[m
       "label": "build",[m
       "detail": "install dependencies from package"[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "type": "docker-build",[m
[32m+[m[32m      "label": "docker-build",[m
[32m+[m[32m      "platform": "node",[m
[32m+[m[32m      "dockerBuild": {[m
[32m+[m[32m        "dockerfile": "${workspaceFolder}/Dockerfile",[m
[32m+[m[32m        "context": "${workspaceFolder}",[m
[32m+[m[32m        "pull": true[m
[32m+[m[32m      }[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "type": "docker-run",[m
[32m+[m[32m      "label": "docker-run: release",[m
[32m+[m[32m      "dependsOn": [[m
[32m+[m[32m        "docker-build"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "platform": "node"[m
[32m+[m[32m    },[m
[32m+[m[32m    {[m
[32m+[m[32m      "type": "docker-run",[m
[32m+[m[32m      "label": "docker-run: debug",[m
[32m+[m[32m      "dependsOn": [[m
[32m+[m[32m        "docker-build"[m
[32m+[m[32m      ],[m
[32m+[m[32m      "dockerRun": {[m
[32m+[m[32m        "env": {[m
[32m+[m[32m          "DEBUG": "*",[m
[32m+[m[32m          "NODE_ENV": "development"[m
[32m+[m[32m        }[m
[32m+[m[32m      },[m
[32m+[m[32m      "node": {[m
[32m+[m[32m        "enableDebugging": true[m
[32m+[m[32m      }[m
     }[m
   ][m
 }[m
[1mdiff --git a/Dockerfile b/Dockerfile[m
[1mnew file mode 100644[m
[1mindex 0000000..bc1ab54[m
[1m--- /dev/null[m
[1m+++ b/Dockerfile[m
[36m@@ -0,0 +1,10 @@[m
[32m+[m[32mFROM node:lts-alpine[m
[32m+[m[32mENV NODE_ENV=production[m
[32m+[m[32mWORKDIR /usr/src/app[m
[32m+[m[32mCOPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"][m
[32m+[m[32mRUN npm install --production --silent && mv node_modules ../[m
[32m+[m[32mCOPY . .[m
[32m+[m[32mEXPOSE 3500[m
[32m+[m[32mRUN chown -R node /usr/src/app[m
[32m+[m[32mUSER node[m
[32m+[m[32mCMD ["npm", "start"][m
