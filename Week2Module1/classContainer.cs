using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Week2Module1
{
    public static class DirectoryHandler
    {
        static int parent;
        public static int parentnode
        {
            get { return parent; }
            set { parent = value; }
        }
    }

    public static class PathStore
    {
        static String path, action, root, relative;
        public static String currentPath
        {
            get { return path; }
            set { path = value; }
        }
        public static String actionPath
        {
            get { return action; }
            set { action = value; }
        }
        public static String basePath
        {
            get { return root; }
            set { root = value; }
        }
        public static String relativePath
        {
            get { return relative; }
            set { relative = value; }
        }
    }

    public static class SessionStore
    {
        static String name;
        static String user;
        public static String handle
        {
            get { return name; }
            set { name = value; }
        }
        public static String username
        {
            get { return user; }
            set { user = value; }
        }
    }
    //String token = cryptedFolderString.Substring(0, 10) + "1" + cryptedFolderString.Substring(11, 20) + "1" + cryptedFolderString.Substring(31, 10);
}