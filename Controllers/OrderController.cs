using MasteDetails_DF.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace MasteDetails_DF.Controllers
{
    public class OrderController : Controller
    {
        public MasterDetailsDB_DBFirstEntities db = new MasterDetailsDB_DBFirstEntities();

        public ActionResult Index()
        {
            return View();
        }
        public JsonResult getProductCategories()
        {
            List<Category> categories = new List<Category>();
            categories = db.Categories.OrderBy(c => c.CategoryName).ToList();
            return new JsonResult { Data = categories, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }
        public JsonResult getProducts(int categoryId)
        {
            List<Product> products = new List<Product>();
            products = db.Products.Where(p => p.CategoryId.Equals(categoryId)).OrderBy(po => po.ProductName).ToList();
            return new JsonResult { Data = products, JsonRequestBehavior = JsonRequestBehavior.AllowGet };
        }

        public JsonResult Save(OrderMaster order, HttpPostedFileBase file)
        {
            bool status = false;
            if (file != null)
            {
                string folderPath = Server.MapPath("~/Images/");
                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                string filePath = Path.Combine(folderPath, fileName);
                file.SaveAs(filePath);
                order.Image = fileName;
            }
            var isvalidmodel = TryUpdateModel(order);
            if (isvalidmodel)
            {
                db.OrderMasters.Add(order);
                db.SaveChanges();
                status = true;
            }
            return new JsonResult { Data = new { status = status } };
        }
    }
}