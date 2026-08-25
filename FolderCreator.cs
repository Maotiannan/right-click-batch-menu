using System;
using System.IO;
using System.Windows.Forms;

class FolderCreator
{
    [STAThread]
    static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            MessageBox.Show("请在文件夹上点击右键，选择\"创建跟单文件夹\"使用。", "提示", MessageBoxButtons.OK, MessageBoxIcon.Information);
            return;
        }

        string targetPath = args[0];
        if (!Directory.Exists(targetPath))
        {
            MessageBox.Show("目标文件夹不存在：\n" + targetPath, "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return;
        }

        string[] folders = {
            "1.PI",
            "2.采购合同",
            "3.码单",
            "4.进仓申请",
            "5.单证资料",
            "6.装柜图片",
            "7.客户发票",
            "8.信保资料",
            "9.开票通知"
        };

        int created = 0;
        int skipped = 0;
        foreach (string folder in folders)
        {
            string fullPath = Path.Combine(targetPath, folder);
            if (Directory.Exists(fullPath))
            {
                skipped++;
            }
            else
            {
                try
                {
                    Directory.CreateDirectory(fullPath);
                    created++;
                }
                catch (Exception ex)
                {
                    MessageBox.Show("创建文件夹失败：" + folder + "\n" + ex.Message, "错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
            }
        }

        // 成功不弹窗，静默完成
    }
}
