using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using lab_8_9_api;

namespace lab_8_9_api.Data
{
    public class lab_8_9_apiContext : DbContext
    {
        public lab_8_9_apiContext (DbContextOptions<lab_8_9_apiContext> options)
            : base(options)
        {
        }

        public DbSet<lab_8_9_api.Book> Book { get; set; } = default!;
    }
}
