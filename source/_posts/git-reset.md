---
title: Git操作流程总结
date: 2018-05-16 10:16:48
tags: [Git]
categories: Git
---
来自[Git的4个阶段的撤销更改](https://www.fengerzh.com/git-reset/)、[Git远程操作详解](http://www.ruanyifeng.com/blog/2014/06/git_remote.html)等博客的学习总结(PS:备份)。
<!--more-->
# Git的基本概念 #
在创建Git仓库的时候，工作区会有一个隐藏目录.git（Git的版本库)，Git会自动创建一个master分支，以及一个指向master分支的指针`HEAD`。
![git工作分区](http://ou3oh86t1.bkt.clouddn.com/git-reset/git%E5%B7%A5%E4%BD%9C%E5%88%86%E5%8C%BA.png)

如上图所示，Git的本地管理主要分为三个区，第一个工作区，第二个暂存区(statge/index)，第三个本地仓库。
1.工作区中文件的增删改，通过`git add <file>`将改动文件添加到暂存区

2.通过`git commit -m "descriptions"`将暂存区的多次改动提交到本地仓库

3.通过`git push`将本地仓库推送到远程仓库。
# Git分支管理 #
每个人在各自的分支上开发，互相不影响，最后由管理员或者自己来合并分支，处理冲突，测试上线。

以下流程包括查看分支、新建并切换到dev分支、在dev分支修改文件后合并到master分支，最后删除dev分支的过程。

![新建并切换分支](http://ou3oh86t1.bkt.clouddn.com/git-reset/%E5%88%87%E6%8D%A2%E5%88%86%E6%94%AF.png)

![合并分支](http://ou3oh86t1.bkt.clouddn.com/git-reset/%E5%90%88%E5%B9%B6%E5%88%86%E6%94%AF.png)

下面的例子演示了从github clone一个`test`仓库到本地，并创建新分支dev，在新分支dev上修改文件，合并到主分支master，最后删除dev分支。（**注意：** 执行`git clone`命令是将远程仓库更新到本地仓库区，而不是本地工作区！）

**查看分支**
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (master)
$ git branch
* master
```
`* master`表示当前分支为master。
**新建并切换分支**
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (master)
$ git checkout -b dev
Switched to a new branch 'dev'
```

```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (dev)
$ git branch
* dev
  master
```
使用`git branch`查看分支，共有两个分支，当前分支为`dev`。

接下来在test文件夹下新建read.txt，并执行`git add readme.txt`和`git commit -m "添加文件测试"`将变化从工作区提交到本地仓库区：
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (dev)
$ git add read.txt
```

```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (dev)
$ git commit -m "添加文件测试"
[dev b150277] 添加文件测试
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 read.txt
```
**合并分支**
首先从dev分支切换回master分支
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (dev)
$ git checkout master
Switched to branch 'master'
Your branch is up-to-date with 'origin/master'.
```
再执行合并dev分支
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (master)
$ git merge dev
Updating d521d20..b150277
Fast-forward
 read.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 read.txt
```
最后删除dev分支
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (master)
$ git branch -d dev
Deleted branch dev (was b150277).
```

```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (master)
$ git branch
* master
```
![团队合作分支](http://ou3oh86t1.bkt.clouddn.com/git-reset/%E5%9B%A2%E9%98%9F%E5%90%88%E4%BD%9C%E5%88%86%E6%94%AF%E7%A4%BA%E6%84%8F%E5%9B%BE.png)

# Git常用指令 #
`git --help`中常见的git操作指令如下：
```bash
start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects
```

- `git branch` 默认查看本地分支
`git branch -a` 查看所有的分支
`git branch -r` 查看远程分支

``` bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (test)
$ git branch
  master
* test


Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (test)
$ git branch -a
  master
* test
  remotes/origin/HEAD -> origin/master
  remotes/origin/master


Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/test (test)
$ git branch -r
  origin/HEAD -> origin/master
  origin/master

```
# Git远程操作 #
![git远程操作示意图](http://ou3oh86t1.bkt.clouddn.com/git-reset/git%E8%BF%9C%E7%A8%8B%E6%93%8D%E4%BD%9C.jpg)
## git clone ##
`git clone <版本库的网址> <本地目录名>`

从远程主机克隆一个版本库，若不带第二个参数，会在本地主机生成一个与远程主机版本库同名的版本库。eg, 克隆github仓库test到本机，并命名为testLocal:
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop
$ git clone https://github.com/shirley5li/test testLocal
```
## git remote ##
Git要求每个远程主机都必须指定一个主机名。`git remote`命令就用于管理主机名。
- 不带参数时，`git remote`命令查看所有远程主机名:
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/testLocal (master)
$ git remote
origin
```
- 带`-v`参数，可以查看所有远程主机名对应的网址：
```bash
Shirley@DESKTOP-G6LSDJO MINGW64 ~/Desktop/testLocal (master)
$ git remote -v
origin  https://github.com/shirley5li/test (fetch)
origin  https://github.com/shirley5li/test (push)
```
**注意：** 克隆版本库的时候，所使用的远程主机名自动被Git命名为origin，如果想用其他的主机名，需要用`git clone`命令的`-o`参数指定。例如，克隆时指定远程主机名为Test，可以使用 `git clone -o Test https://github.com/shirley5li/test`。

- `git remote show <主机名>`，查看主机详细信息。

- `git remote add <主机名> <网址>`，用于添加远程主机。

- `git remote rm <主机名>`，删除远程主机。

- `git remote rename <原主机名> <新主机名>`，更改远程主机的名字。

## git fetch ##
- 用法： `git fetch <远程主机名> <分支名>`

用于将远程主机版本库的更新取回到本地，但不会对本地的开发代码产生影响，当不指定`<分支名>`时，默认取回所有分支的更新。(若要作用到本地代码，还需要配合使用`git merge`)

**注意：** 所取回的更新，在本地主机上要用"远程主机名/分支名"的形式读取。比如`origin`主机的`master`，就要用`origin/master`读取。查看远程分支(`-a`表示查看所有分支)：
```bash
$ git branch -r
origin/master

$ git branch -a
* master
  remotes/origin/master
```
- 取回远程主机的更新以后，可以在它的基础上，使用`git checkout`命令创建一个新的分支：
```bash
git checkout -b newBranch origin/master
```
- 使用`git merge`或`git rebase`命令，在本地分支上合并远程分支。以下表示在当前分支上，合并`origin/master`：
```bash
$ git merge origin/master
$ git rebase origin/master
```

## git pull ##
- 用法： `git pull <远程主机名> <远程分支名>:<本地分支名>`

用于取回远程主机某个分支的更新，再与本地的指定分支合并，如果远程分支是与当前分支合并，则冒号后面的部分可以省略。

例如，取回远程`origin/next`分支，再与当前分支合并，等同于先`git fetch`，再`git merge`：
```bash
$ git pull origin next
# 等同于
$ git fetch origin
$ git merge origin/next
```
- 若当前分支与远程分支存在tracking关系，`git pull`可以省略远程分支名。

在某些场合，Git会自动在本地分支与远程分支之间，建立一种追踪关系（tracking）。比如，在`git clone`的时候，所有本地分支默认与远程主机的同名分支，建立追踪关系，即本地的`master`分支自动tracking `origin/master`分支。

Git也允许手动建立追踪关系，如下指定本地`master`分支tracking `origin/next`分支：
```bash
git branch --set-upstream master origin/next
```
此时，`git pull`可以省略远程分支名：
```bash
$ git pull origin
```
- 若当前分支只有一个tracking分支，还可以省略远程主机名：

```bash
$ git pull
```
上面命令表示，当前分支自动与唯一一个tracking分支进行合并。

- 采用`--rebase`模式: `git pull --rebase <远程主机名> <远程分支名>:<本地分支名>`【[git merge 和 git rebase 小结](https://blog.csdn.net/wh_19910525/article/details/7554489)】

- 加上参数 `-p`

如果远程主机删除了某个分支，默认情况下，`git pull`不会在拉取远程分支的时候，删除对应的本地分支。这是为了防止，由于其他人操作了远程主机，导致`git pull`不知不觉删除了本地分支，通过添加参数`-p`可以在本地删除远程已经删除的分支。
```bash
$ git pull -p
# 等同于下面的命令
$ git fetch --prune origin 
$ git fetch -p
```
## git push ##
- 用法： `git push <远程主机名> <本地分支>:<远程分支>`

用于将本地分支的更新，推送到远程主机。
- 省略远程分支名

如果省略远程分支名，则表示将本地分支推送到与之存在tracking关系的远程分支（通常两者同名），如果该远程分支不存在，则会被新建，例如`git push origin master`表示将本地的`master`分支推送到`origin`主机的`master`分支，如果后者不存在，则会被新建。

- 省略本地分支名

表示删除指定的远程分支，等同于推送一个空的本地分支到远程分支，以下命令表示删除`origin`主机的`master`分支：
```bash
$ git push origin :master
# 等同于
$ git push origin --delete master
```
- 省略本地分支和远程分支

如果当前分支与远程分支之间存在tracking系，则本地分支和远程分支都可以省略: `git push origin`。

- 省略远程主机名

如果当前分支只有一个追踪分支，那么主机名也可以省略： `git push`。

# Git的4个阶段的撤销更改 #
![Git基本操作流程](http://ou3oh86t1.bkt.clouddn.com/git-reset/git-commands.png)

该部分内容假设只有一个主分支master。
## 4个区 ##
- 工作区(Working Area)
- 暂存区(Stage)
- 本地仓库(Local Repository)
- 远程仓库(Remote Repository)

## 5种状态 ##
以上4个区，进入每一个区成功之后会产生一个状态，再加上最初始的一个状态，一共是5种状态。

- 未修改(Origin)
- 已修改(Modified)
- 已暂存(Staged)
- 已提交(Committed)
- 已推送(Pushed)

## 检查修改 ##
### 已修改，未暂存 ###
```bash
git diff
```
`git diff`这个命令只检查工作区和暂存区之间的差异。
### 已暂存，未提交 ###
```bash
git diff --cached
```
`git diff --cached`用于检查暂存区到本地仓库之间的差异。
### 已提交，未推送 ###
```bash
git diff master origin/master
```
这里，`master`表示的本地仓库分支，而`origin/master`表示远程仓库分支。以上命令用于检查本地仓库与远程仓库之间的差异。
## 撤销修改 ##
### 已修改，未暂存 ###
```bash
git checkout .
```
或者
```bash
git reset --hard
```
做完修改之后，如果你想向前走一步，让修改进入暂存区，就执行`git add .`，如果你想向后退一步，撤销刚才的修改，就执行`git checkout .`。
### 已暂存，未提交 ###
```bash
git reset
git checkout .
```
或者
```bash
git reset --hard
```
`git reset`只是把修改退回到了`git add .`之前的状态，即文件本身还处于已修改未暂存状态，你如果想退回未修改状态，还需要执行`git checkout .`。
### 已提交，未推送 ###
```bash
git reset --hard origin/master
```
此刻的状态已经污染了本地仓库，需要从远程仓库把代码取回来。
### 已推送 ###
```
git reset --hard HEAD^
git push -f
```
此刻已经污染了远程仓库，需要先恢复本地仓库，再强制push到远程仓库。