﻿using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InteliPharma.Console.Database
{
    public interface IConnect
    {
        ApplicationDbContext GetContext();

    }
}
